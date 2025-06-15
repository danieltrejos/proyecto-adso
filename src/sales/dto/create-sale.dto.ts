import {
  IsNumber,
  IsArray,
  IsOptional,
  IsString,
  ValidateNested,
  IsPositive
} from 'class-validator';
import { Type } from 'class-transformer';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateSaleItemDto {
  @ApiProperty({
    description: 'ID del producto a vender',
    example: 1,
    minimum: 1
  })
  @IsNumber()
  productId: number;

  @ApiProperty({
    description: 'Cantidad del producto a vender',
    example: 2,
    minimum: 1
  })
  @IsNumber()
  @IsPositive()
  quantity: number;

  @ApiProperty({
    description: 'Precio del producto al momento de la venta',
    example: 7.99,
    minimum: 0.01
  })
  @IsNumber()
  @IsPositive()
  price: number;
}

export class CreateSaleDto {
  @ApiProperty({
    description: 'Total de la venta (calculado automáticamente)',
    example: 15.98,
    minimum: 0.01
  })
  @IsNumber()
  @IsPositive()
  total: number;

  @ApiProperty({
    description: 'Subtotal sin impuestos',
    example: 14.53,
    minimum: 0.01
  })
  @IsNumber()
  @IsPositive()
  subtotal: number;

  @ApiProperty({
    description: 'Monto de impuestos calculado',
    example: 1.45,
    minimum: 0
  })
  @IsNumber()
  taxAmount: number;

  @ApiProperty({
    description: 'Porcentaje de impuesto aplicado',
    example: 10.0,
    minimum: 0
  })
  @IsNumber()
  taxRate: number;

  @ApiProperty({
    description: 'Monto pagado por el cliente',
    example: 20.0,
    minimum: 0.01
  })
  @IsNumber()
  @IsPositive()
  paymentAmount: number;

  @ApiProperty({
    description: 'Cambio devuelto al cliente',
    example: 4.02,
    minimum: 0
  })
  @IsNumber()
  change: number;

  @ApiPropertyOptional({
    description: 'Método de pago utilizado',
    example: 'Efectivo',
    enum: ['Efectivo', 'Tarjeta', 'Transferencia']
  })
  @IsOptional()
  @IsString()
  paymentMethod?: string;

  @ApiProperty({
    description: 'ID del usuario que realiza la venta',
    example: 1,
    minimum: 1
  })
  @IsNumber()
  userId: number;

  @ApiPropertyOptional({
    description: 'ID del cliente (opcional para ventas sin cliente registrado)',
    example: 1,
    minimum: 1
  })
  @IsOptional()
  @IsNumber()
  customerId?: number;

  @ApiProperty({
    description: 'ID de la empresa',
    example: 'cmbsj3d7v0000um9c91vyzwez'
  })
  @IsString()
  companyId: string;

  @ApiProperty({
    description: 'Lista de productos vendidos con sus cantidades y precios',
    type: [CreateSaleItemDto],
    example: [
      { productId: 1, quantity: 2, price: 7.99 },
      { productId: 3, quantity: 1, price: 3.5 }
    ]
  })
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CreateSaleItemDto)
  items: CreateSaleItemDto[];
}
