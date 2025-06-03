//import { Product } from 'generated/prisma';
//export type CreateProductDto = Omit<Product, 'id' | 'createdAt' | 'updatedAt'>
import { IsString, IsNotEmpty, IsOptional, IsNumber, IsPositive } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateProductDto {
  @ApiProperty({
    description: 'Nombre del producto',
    example: 'Cerveza Corona Extra'
  })
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiPropertyOptional({
    description: 'Descripción del producto',
    example: 'Cerveza mexicana ligera y refrescante'
  })
  @IsOptional()
  description?: string;

  @ApiPropertyOptional({
    description: 'Tipo o categoría del producto',
    example: 'Cerveza'
  })
  @IsOptional()
  type?: string;

  @ApiProperty({
    description: 'Precio del producto',
    example: 2500,
    minimum: 0.01
  })
  @IsNotEmpty()
  @IsNumber()
  @IsPositive()
  price: number;

  @ApiProperty({
    description: 'Cantidad en stock',
    example: 50,
    minimum: 0
  })
  @IsNotEmpty()
  @IsNumber()
  stock: number;

  @ApiPropertyOptional({
    description: 'URL de la imagen del producto',
    example: 'https://example.com/corona.jpg'
  })
  @IsOptional()
  @IsString()
  image?: string;
}
