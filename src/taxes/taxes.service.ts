import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { CreateTaxDto } from './dto/create-tax.dto';
import { UpdateTaxDto } from './dto/update-tax.dto';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class TaxesService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(createTaxDto: CreateTaxDto) {
    try {
      // Si se está creando un impuesto por defecto, desactivar otros por defecto
      if (createTaxDto.isDefault) {
        await this.prismaService.tax.updateMany({
          where: { isDefault: true },
          data: { isDefault: false }
        });
      }

      return await this.prismaService.tax.create({
        data: {
          ...createTaxDto,
          isActive: createTaxDto.isActive ?? true,
          isDefault: createTaxDto.isDefault ?? false
        }
      });
    } catch (error) {
      console.log('Error al crear impuesto:', error);
      throw new Error('Error al crear el impuesto');
    }
  }

  async findAll() {
    return await this.prismaService.tax.findMany({
      orderBy: { createdAt: 'desc' }
    });
  }

  async findActive() {
    return await this.prismaService.tax.findMany({
      where: { isActive: true },
      orderBy: { isDefault: 'desc' } // Primero el por defecto
    });
  }

  async findDefault() {
    return await this.prismaService.tax.findFirst({
      where: {
        isDefault: true,
        isActive: true
      }
    });
  }

  async findOne(id: number) {
    const tax = await this.prismaService.tax.findUnique({
      where: { id }
    });

    if (!tax) {
      throw new NotFoundException(`Impuesto con ID ${id} no encontrado`);
    }
    return tax;
  }

  async update(id: number, updateTaxDto: UpdateTaxDto) {
    await this.findOne(id); // Verificar que existe

    // Si se está marcando como por defecto, desactivar otros por defecto
    if (updateTaxDto.isDefault) {
      await this.prismaService.tax.updateMany({
        where: {
          id: { not: id },
          isDefault: true
        },
        data: { isDefault: false }
      });
    }

    try {
      return await this.prismaService.tax.update({
        where: { id },
        data: updateTaxDto
      });
    } catch (error) {
      console.log('Error al actualizar impuesto:', error);
      throw new Error('Error al actualizar el impuesto');
    }
  }

  async remove(id: number) {
    const tax = await this.findOne(id); // Verificar que existe

    // No permitir eliminar el impuesto por defecto si es el único activo
    if (tax.isDefault) {
      const activeTaxesCount = await this.prismaService.tax.count({
        where: { isActive: true }
      });

      if (activeTaxesCount <= 1) {
        throw new ConflictException('No se puede eliminar el único impuesto activo por defecto');
      }
    }

    return await this.prismaService.tax.delete({
      where: { id }
    });
  }

  async setDefault(id: number) {
    await this.findOne(id); // Verificar que existe

    // Desactivar otros por defecto
    await this.prismaService.tax.updateMany({
      where: { isDefault: true },
      data: { isDefault: false }
    });

    // Marcar como por defecto y activar
    return await this.prismaService.tax.update({
      where: { id },
      data: {
        isDefault: true,
        isActive: true
      }
    });
  }
}
