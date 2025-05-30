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
  @ApiProperty({ description: 'ID del producto', example: 1 })
  @IsNumber()
  productId: number;

  @ApiProperty({ description: 'Cantidad del producto', example: 2 })
  @IsNumber()
  @IsPositive()
  quantity: number;

  @ApiProperty({ description: 'Precio del producto al momento de la venta', example: 7.99 })
  @IsNumber()
  @IsPositive()
  price: number;
}

export class CreateSaleDto {
  @ApiProperty({ description: 'Total de la venta', example: 15.98 })
  @IsNumber()
  @IsPositive()
  total: number;

  @ApiProperty({ description: 'Monto pagado por el cliente', example: 20.0 })
  @IsNumber()
  @IsPositive()
  paymentAmount: number;

  @ApiProperty({ description: 'Cambio devuelto al cliente', example: 4.02 })
  @IsNumber()
  change: number;

  @ApiPropertyOptional({ description: 'Método de pago', example: 'Cash' })
  @IsOptional()
  @IsString()
  paymentMethod?: string;

  @ApiProperty({ description: 'ID del usuario que realiza la venta', example: 1 })
  @IsNumber()
  userId: number;

  @ApiPropertyOptional({ description: 'ID del cliente (opcional)', example: 1 })
  @IsOptional()
  @IsNumber()
  customerId?: number;

  @ApiProperty({ description: 'Items de la venta', type: [CreateSaleItemDto] })
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CreateSaleItemDto)
  items: CreateSaleItemDto[];
}
