export interface DashboardStatsDto {
  totalProducts: number;
  lowStockCount: number;
  monthlySales: number;
  monthlyRevenue: number;
}

export interface SalesByMonthDto {
  month: string;
  sales: number;
  revenue: number;
}

export interface RecentSaleDto {
  id: number;
  total: number;
  customerName: string | null;
  paymentMethod: string;
  createdAt: Date;
  itemCount: number;
}
