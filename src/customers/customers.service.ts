/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-return */
import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateCustomerDto } from './dto/create-customer.dto';
import { UpdateCustomerDto } from './dto/update-customer.dto';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class CustomersService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(createCustomerDto: CreateCustomerDto) {
    try {
      return await this.prismaService.customer.create({
        data: createCustomerDto
      });
    } catch (error) {
      console.log('Error al crear cliente:', error);
      throw new Error('Error al crear el cliente');
    }
  }

  async findAll() {
    return await this.prismaService.customer.findMany({
      orderBy: { createdAt: 'desc' }
    });
  }

  async findOne(id: number) {
    const customer = await this.prismaService.customer.findUnique({
      where: { id },
      include: {
        sales: {
          include: {
            items: {
              include: {
                product: true
              }
            },
            user: true
          }
        }
      }
    });

    if (!customer) {
      throw new NotFoundException(`Cliente con ID ${id} no encontrado`);
    }
    return customer;
  }

  async update(id: number, updateCustomerDto: UpdateCustomerDto) {
    const customerUpdate = await this.prismaService.customer.update({
      where: { id },
      data: updateCustomerDto
    });

    if (!customerUpdate) {
      throw new NotFoundException(`Cliente con ID ${id} no encontrado`);
    }
    return customerUpdate;
  }

  async remove(id: number) {
    const deletedCustomer = await this.prismaService.customer.delete({
      where: { id }
    });

    if (!deletedCustomer) {
      throw new NotFoundException(`Cliente con ID ${id} no encontrado`);
    }
    return deletedCustomer;
  }
}
