import { Controller, Get } from '@nestjs/common';
import { StatsService } from './stats.service';
import { DashboardStatsDto, SalesByMonthDto, RecentSaleDto } from './dto/dashboard-stats.dto';

@Controller('stats')
export class StatsController {
  constructor(private readonly statsService: StatsService) {}

  @Get('dashboard')
  getDashboardStats(): Promise<DashboardStatsDto> {
    return this.statsService.getDashboardStats();
  }

  @Get('sales-by-month')
  getSalesByMonth(): Promise<SalesByMonthDto[]> {
    return this.statsService.getSalesByMonth();
  }

  @Get('recent-sales')
  getRecentSales(): Promise<RecentSaleDto[]> {
    return this.statsService.getRecentSales();
  }
}
