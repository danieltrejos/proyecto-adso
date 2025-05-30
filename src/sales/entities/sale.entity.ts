import { SaleItem } from './sale-item.entity';

export class Sale {
  id: number;
  total: number;
  paymentAmount: number;
  change: number;
  paymentMethod: string;
  userId: number;
  customerId?: number;
  createdAt: Date;
  updatedAt: Date;

  // Relaciones
  items?: SaleItem[];
}
