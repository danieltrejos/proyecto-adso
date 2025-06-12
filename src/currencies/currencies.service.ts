/* eslint-disable @typescript-eslint/no-unsafe-member-access */
import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { CreateCurrencyDto } from './dto/create-currency.dto';
import { UpdateCurrencyDto } from './dto/update-currency.dto';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class CurrenciesService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(createCurrencyDto: CreateCurrencyDto) {
    try {
      return await this.prismaService.currency.create({
        data: {
          ...createCurrencyDto,
          precision: createCurrencyDto.precision ?? 2,
          thousandSeparator: createCurrencyDto.thousandSeparator ?? ',',
          decimalSeparator: createCurrencyDto.decimalSeparator ?? '.',
          isActive: createCurrencyDto.isActive ?? true
        }
      });
    } catch (error) {
      if (error.code === 'P2002') {
        throw new ConflictException('Ya existe una moneda con este código');
      }
      console.log('Error al crear moneda:', error);
      throw new Error('Error al crear la moneda');
    }
  }

  async findAll() {
    return await this.prismaService.currency.findMany({
      orderBy: { createdAt: 'desc' }
    });
  }

  async findActive() {
    return await this.prismaService.currency.findMany({
      where: { isActive: true },
      orderBy: { name: 'asc' }
    });
  }

  async findByCode(code: string) {
    return await this.prismaService.currency.findUnique({
      where: { code: code.toUpperCase() }
    });
  }

  async findOne(id: number) {
    const currency = await this.prismaService.currency.findUnique({
      where: { id }
    });

    if (!currency) {
      throw new NotFoundException(`Moneda con ID ${id} no encontrada`);
    }
    return currency;
  }

  async update(id: number, updateCurrencyDto: UpdateCurrencyDto) {
    await this.findOne(id); // Verificar que existe

    try {
      return await this.prismaService.currency.update({
        where: { id },
        data: updateCurrencyDto
      });
    } catch (error) {
      if (error.code === 'P2002') {
        throw new ConflictException('Ya existe una moneda con este código');
      }
      console.log('Error al actualizar moneda:', error);
      throw new Error('Error al actualizar la moneda');
    }
  }

  async remove(id: number) {
    await this.findOne(id); // Verificar que existe

    try {
      return await this.prismaService.currency.delete({
        where: { id }
      });
    } catch (error) {
      if (error.code === 'P2003') {
        throw new ConflictException('No se puede eliminar la moneda porque está siendo utilizada');
      }
      throw error;
    }
  }

  async activate(id: number) {
    await this.findOne(id); // Verificar que existe

    return await this.prismaService.currency.update({
      where: { id },
      data: { isActive: true }
    });
  }

  async deactivate(id: number) {
    await this.findOne(id); // Verificar que existe

    // Verificar que no es la única moneda activa
    const activeCurrenciesCount = await this.prismaService.currency.count({
      where: { isActive: true }
    });

    if (activeCurrenciesCount <= 1) {
      throw new ConflictException('No se puede desactivar la única moneda activa');
    }

    return await this.prismaService.currency.update({
      where: { id },
      data: { isActive: false }
    });
  }
}
