/* eslint-disable @typescript-eslint/no-unsafe-assignment */

/* eslint-disable @typescript-eslint/no-unsafe-member-access */
import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { CreateProductDto } from './dto/create-product.dto';
import { UpdateProductDto } from './dto/update-product.dto';
import { GetProductsDto } from './dto/get-products.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class ProductsService {
  // Inyección de dependencias
  constructor(private readonly prismaService: PrismaService) {}

  // POST /api/v1/products
  create(createProductDto: CreateProductDto) {
    try {
      return this.prismaService.product.create({
        data: createProductDto
      });
    } catch (error) {
      console.log('Error en el servicio de productos:', error);
      throw new Error('Error al crear el producto');
    }
  }
  // GET /api/v1/products con paginación y filtros
  async findAllPaginated(filters: GetProductsDto) {
    const { page = 1, limit = 10, name, type, minPrice, maxPrice, minStock, all = false } = filters;

    // Construir el objeto where dinámicamente
    const where: any = {};

    if (name) {
      where.name = {
        contains: name,
        mode: 'insensitive' // Búsqueda insensible a mayúsculas/minúsculas
      };
    }

    if (type) {
      where.type = {
        contains: type,
        mode: 'insensitive'
      };
    }

    if (minPrice !== undefined) {
      where.price = {
        ...where.price,
        gte: minPrice
      };
    }

    if (maxPrice !== undefined) {
      where.price = {
        ...where.price,
        lte: maxPrice
      };
    }

    if (minStock !== undefined) {
      where.stock = {
        gte: minStock
      };
    }

    // Si se solicita "all", devolver todos los productos sin paginación
    if (all) {
      const products = await this.prismaService.product.findMany({
        where,
        orderBy: {
          createdAt: 'desc'
        }
      });

      // Para componentes que esperan un array directamente (POS, Inventory)
      return products;
    }

    // Calcular offset para paginación
    const skip = (page - 1) * limit;

    // Ejecutar consultas en paralelo
    const [products, total] = await Promise.all([
      this.prismaService.product.findMany({
        where,
        skip,
        take: limit,
        orderBy: {
          createdAt: 'desc'
        }
      }),
      this.prismaService.product.count({
        where
      })
    ]);

    const totalPages = Math.ceil(total / limit);

    return {
      products,
      total,
      page,
      limit,
      totalPages
    };
  }

  // GET /api/v1/products (método original para compatibilidad)
  findAll() {
    return this.prismaService.product.findMany({
      orderBy: {
        createdAt: 'desc'
      }
    });
  }

  // GET /api/v1/products/:id
  async findOne(id: number) {
    const productFound = await this.prismaService.product.findUnique({ where: { id: id } });
    // Validación de que el producto existe
    if (!productFound) {
      throw new NotFoundException(`Product with id ${id} not found`);
    }
    return productFound;
  }

  async update(id: number, updateProductDto: UpdateProductDto) {
    const productUpdate = await this.prismaService.product.update({
      where: { id },
      data: updateProductDto
    });
    // Validación de que el producto existe
    if (!productUpdate) {
      throw new NotFoundException(`Product with id ${id} not found`);
    }
    return productUpdate;
  }
  async remove(id: number) {
    const deletedProduct = await this.prismaService.product.delete({ where: { id } });
    // Validación de que el producto existe
    if (!deletedProduct) {
      throw new NotFoundException(`Product with id ${id} not found`);
    }
    return deletedProduct;
  }

  //Añadido para reabastecer el stock de un producto
  // PATCH /api/v1/products/:id/restock
  async restock(id: number, amount: number) {
    if (amount <= 0) {
      throw new BadRequestException('El valor de reabastecimiento debe ser mayor a cero.');
    }

    const product = await this.prismaService.product.findUnique({ where: { id } });
    if (!product) {
      throw new NotFoundException('Producto no encontrado');
    }

    return this.prismaService.product.update({
      where: { id },
      data: {
        stock: {
          increment: amount // Aumenta el stock de forma segura
        }
      }
    });
  }

  // PATCH /api/v1/products/:id/outbound
  async outbound(id: number, amount: number) {
    if (amount <= 0) {
      throw new BadRequestException('La cantidad de salida debe ser mayor a cero.');
    }

    const product = await this.prismaService.product.findUnique({ where: { id } });
    if (!product) {
      throw new NotFoundException('Producto no encontrado');
    }

    if (product.stock < amount) {
      throw new BadRequestException(
        `Stock insuficiente. Stock actual: ${product.stock}, cantidad solicitada: ${amount}`
      );
    }

    return this.prismaService.product.update({
      where: { id },
      data: {
        stock: {
          decrement: amount // Reduce el stock de forma segura
        }
      }
    });
  }
}
