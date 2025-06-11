/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-return */
import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { CreateCompanyDto } from './dto/create-company.dto';
import { UpdateCompanyDto } from './dto/update-company.dto';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class CompaniesService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(createCompanyDto: CreateCompanyDto) {
    try {
      return await this.prismaService.company.create({
        data: createCompanyDto,
      });
    } catch (error) {
      if (error.code === 'P2002') {
        throw new ConflictException('Ya existe una empresa con este email');
      }
      throw error;
    }
  }

  async findAll() {
    return await this.prismaService.company.findMany({
      orderBy: { createdAt: 'desc' },
    });
  }

  async findOne(id: string) {
    const company = await this.prismaService.company.findUnique({
      where: { id },
    });

    if (!company) {
      throw new NotFoundException(`Empresa con ID ${id} no encontrada`);
    }

    return company;
  }

  async update(id: string, updateCompanyDto: UpdateCompanyDto) {
    await this.findOne(id); // Verificar que existe

    try {
      return await this.prismaService.company.update({
        where: { id },
        data: updateCompanyDto,
      });
    } catch (error) {
      if (error.code === 'P2002') {
        throw new ConflictException('Ya existe una empresa con este email');
      }
      throw error;
    }
  }

  async remove(id: string) {
    await this.findOne(id); // Verificar que existe

    return await this.prismaService.company.delete({
      where: { id },
    });
  }

  // Método adicional para obtener la configuración principal
  async getMainCompany() {
    const companies = await this.prismaService.company.findMany({
      orderBy: { createdAt: 'asc' },
      take: 1,
    });
    return companies[0] || null;
  }
}
