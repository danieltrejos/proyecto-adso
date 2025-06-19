import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { DashboardStatsDto, SalesByMonthDto, RecentSaleDto } from './dto/dashboard-stats.dto';

@Injectable()
export class StatsService {
  constructor(private readonly prismaService: PrismaService) {}

  async getDashboardStats(): Promise<DashboardStatsDto> {
    const now = new Date();
    const startOfMonth = new Date(now.getFullYear(), now.getMonth(), 1);
    const endOfMonth = new Date(now.getFullYear(), now.getMonth() + 1, 0, 23, 59, 59);

    // Total products count
    const totalProducts = await this.prismaService.product.count();

    // Low stock count (products with stock < 100)
    const lowStockCount = await this.prismaService.product.count({
      where: {
        stock: {
          lt: 100
        }
      }
    });

    // Monthly sales count and revenue
    const monthlySalesData = await this.prismaService.sale.aggregate({
      where: {
        createdAt: {
          gte: startOfMonth,
          lte: endOfMonth
        }
      },
      _count: {
        id: true
      },
      _sum: {
        total: true
      }
    });

    return {
      totalProducts,
      lowStockCount,
      monthlySales: monthlySalesData._count.id || 0,
      monthlyRevenue: monthlySalesData._sum.total || 0
    };
  }
  async getSalesByMonth(): Promise<SalesByMonthDto[]> {
    // Get sales data for the last 12 months
    const salesByMonth = await this.prismaService.$queryRaw<
      Array<{ month: string; sales: bigint; revenue: number }>
    >`
      SELECT 
        TO_CHAR(DATE_TRUNC('month', "createdAt"), 'YYYY-MM') as month,
        COUNT(*)::bigint as sales,
        COALESCE(SUM("total"), 0)::float as revenue
      FROM "sales"
      WHERE "createdAt" >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '11 months')
      GROUP BY DATE_TRUNC('month', "createdAt")
      ORDER BY month ASC
    `;

    // Convert bigint to number and format the response
    return salesByMonth.map((item) => ({
      month: item.month,
      sales: Number(item.sales),
      revenue: item.revenue
    }));
  }
  async getRecentSales(): Promise<RecentSaleDto[]> {
    const recentSales = await this.prismaService.sale.findMany({
      take: 5,
      orderBy: {
        createdAt: 'desc'
      },
      include: {
        customer: {
          select: {
            name: true
          }
        },
        items: {
          select: {
            quantity: true
          }
        }
      }
    });

    return recentSales.map((sale) => ({
      id: sale.id,
      total: sale.total,
      customerName: sale.customer?.name || null,
      paymentMethod: sale.paymentMethod,
      createdAt: sale.createdAt,
      itemCount: sale.items.reduce((sum, item) => sum + item.quantity, 0)
    }));
  }
}
