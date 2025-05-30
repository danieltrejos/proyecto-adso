/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-return */
import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class UsersService {
  // Inyección de dependencias
  constructor(private readonly prismaService: PrismaService) {}

  // Este servicio se encarga de la lógica de negocio relacionada con los usuarios

  // POST /api/v1/users
  async create(createUserDto: CreateUserDto) {
    try {
      return await this.prismaService.user.create({
        data: {
          ...createUserDto,
          role: createUserDto.role || 'bartender'
        }
      });
    } catch (error) {
      console.log('Error al crear usuario:', error);
      throw new Error('Error al crear el usuario');
    }
  }
  // GET /api/v1/users
  async findAll() {
    return await this.prismaService.user.findMany({
      orderBy: { createdAt: 'desc' }
    });
  }
  // GET /api/v1/users/:id
  async findOne(id: number) {
    const user = await this.prismaService.user.findUnique({
      where: { id },
      include: {
        sales: {
          include: {
            customer: true,
            items: {
              include: {
                product: true
              }
            }
          }
        }
      }
    });

    if (!user) {
      throw new NotFoundException(`Usuario con ID ${id} no encontrado`);
    }
    return user;
  }
  // PUT /api/v1/users/:id
  async update(id: number, updateUserDto: UpdateUserDto) {
    const userUpdate = await this.prismaService.user.update({
      where: { id },
      data: updateUserDto
    });

    if (!userUpdate) {
      throw new NotFoundException(`Usuario con ID ${id} no encontrado`);
    }
    return userUpdate;
  }
  // DELETE /api/v1/users/:id
  async remove(id: number) {
    const deletedUser = await this.prismaService.user.delete({
      where: { id }
    });

    if (!deletedUser) {
      throw new NotFoundException(`Usuario con ID ${id} no encontrado`);
    }
    return deletedUser;
  }
}
