export class Customer {
  id: number;
  name: string;
  email?: string;
  phone?: string;
  address?: string; // NUEVO - Dirección del cliente para facturación
  createdAt: Date;
  updatedAt: Date;
}
