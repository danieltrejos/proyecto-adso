import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { CreateSaleDto } from './dto/create-sale.dto';
//import { UpdateSaleDto } from './dto/update-sale.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class SalesService {
  constructor(private readonly prismaService: PrismaService) {}
  async create(createSaleDto: CreateSaleDto) {
    const { items, ...saleData } = createSaleDto;

    try {
      // Verificar que todos los productos existen y tienen stock suficiente
      for (const item of items) {
        const product = await this.prismaService.product.findUnique({
          where: { id: item.productId }
        });

        if (!product) {
          throw new BadRequestException(`Producto con ID ${item.productId} no encontrado`);
        }

        if (product.stock < item.quantity) {
          throw new BadRequestException(`Stock insuficiente para el producto ${product.name}`);
        }
      }

      // Generar número de factura único
      const invoiceNumber = await this.generateInvoiceNumber();

      // Crear la venta con sus items y actualizar el stock
      const sale = await this.prismaService.$transaction(async (prisma) => {
        // Crear la venta
        const newSale = await prisma.sale.create({
          data: {
            ...saleData,
            invoiceNumber, // NUEVO - Agregar número de factura
            items: {
              create: items.map((item) => ({
                productId: item.productId,
                quantity: item.quantity,
                price: item.price
              }))
            }
          },
          include: {
            items: {
              include: {
                product: true
              }
            },
            user: true,
            customer: true,
            company: true // NUEVO - Incluir datos de la empresa
          }
        });

        // Actualizar el stock de los productos
        for (const item of items) {
          await prisma.product.update({
            where: { id: item.productId },
            data: {
              stock: {
                decrement: item.quantity
              }
            }
          });
        }

        return newSale;
      });

      return sale;
    } catch (error) {
      console.log('Error al crear venta:', error);
      throw error;
    }
  }
  async findAll() {
    return await this.prismaService.sale.findMany({
      include: {
        items: {
          include: {
            product: true
          }
        },
        user: true,
        customer: true,
        company: true // NUEVO - Incluir datos de la empresa
      },
      orderBy: { createdAt: 'desc' }
    });
  }
  async findOne(id: number) {
    const sale = await this.prismaService.sale.findUnique({
      where: { id },
      include: {
        items: {
          include: {
            product: true
          }
        },
        user: true,
        customer: true,
        company: true // NUEVO - Incluir datos de la empresa
      }
    });

    if (!sale) {
      throw new NotFoundException(`Venta con ID ${id} no encontrada`);
    }
    return sale;
  }
  async findByUser(userId: number) {
    return await this.prismaService.sale.findMany({
      where: { userId },
      include: {
        items: {
          include: {
            product: true
          }
        },
        customer: true,
        company: true // NUEVO - Incluir datos de la empresa
      },
      orderBy: { createdAt: 'desc' }
    });
  }

  async findByDateRange(startDate: Date, endDate: Date) {
    return await this.prismaService.sale.findMany({
      where: {
        createdAt: {
          gte: startDate,
          lte: endDate
        }
      },
      include: {
        items: {
          include: {
            product: true
          }
        },
        user: true,
        customer: true,
        company: true // NUEVO - Incluir datos de la empresa
      },
      orderBy: { createdAt: 'desc' }
    });
  }

  async getSalesReport() {
    const today = new Date();
    const startOfDay = new Date(today.getFullYear(), today.getMonth(), today.getDate());
    const endOfDay = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1);

    const [todaySales, totalSales, topProducts] = await Promise.all([
      // Ventas de hoy
      this.prismaService.sale.aggregate({
        where: {
          createdAt: {
            gte: startOfDay,
            lt: endOfDay
          }
        },
        _sum: {
          total: true
        },
        _count: true
      }),

      // Total de ventas
      this.prismaService.sale.aggregate({
        _sum: {
          total: true
        },
        _count: true
      }),

      // Productos más vendidos
      this.prismaService.saleItem.groupBy({
        by: ['productId'],
        _sum: {
          quantity: true
        },
        orderBy: {
          _sum: {
            quantity: 'desc'
          }
        },
        take: 5
      })
    ]);

    return {
      todaySales: {
        total: todaySales._sum.total || 0,
        count: todaySales._count
      },
      totalSales: {
        total: totalSales._sum.total || 0,
        count: totalSales._count
      },
      topProducts
    };
  }

  // NUEVO - Generar número de factura único
  private async generateInvoiceNumber(): Promise<string> {
    const lastSale = await this.prismaService.sale.findFirst({
      where: { invoiceNumber: { not: null } },
      orderBy: { createdAt: 'desc' }
    });

    const nextNumber = lastSale ? parseInt(lastSale.invoiceNumber!.replace(/\D/g, '')) + 1 : 1;

    return `FAC-${nextNumber.toString().padStart(5, '0')}`;
  }

  // NUEVO - Método para obtener venta con datos completos para facturación
  async findOneForInvoice(id: number) {
    const sale = await this.prismaService.sale.findUnique({
      where: { id },
      include: {
        items: { include: { product: true } },
        user: true,
        customer: true,
        company: true // Datos de la empresa para la factura
      }
    });

    if (!sale) {
      throw new NotFoundException(`Venta con ID ${id} no encontrada`);
    }
    return sale;
  }
}
