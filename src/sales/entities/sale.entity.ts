import { SaleItem } from './sale-item.entity';

export class Sale {
  id: number;
  total: number;
  subtotal: number; // NUEVO - Subtotal sin impuestos
  taxAmount: number; // NUEVO - Monto de impuestos calculado
  taxRate: number; // NUEVO - Porcentaje de impuesto aplicado
  paymentAmount: number;
  change: number;
  paymentMethod: string;
  invoiceNumber?: string; // NUEVO - Número de factura único
  userId: number;
  customerId?: number;
  companyId: string; // NUEVO - ID de la empresa
  createdAt: Date;
  updatedAt: Date;

  // Relaciones
  items?: SaleItem[];
  user?: any; // Usuario que realizó la venta
  customer?: any; // Cliente de la venta
  company?: any; // Empresa asociada
}
