import { ApiProperty } from '@nestjs/swagger';

export class Currency {
  @ApiProperty({
    description: 'ID único de la moneda',
    example: 1
  })
  id: number;

  @ApiProperty({
    description: 'Código de la moneda (ISO 4217)',
    example: 'USD'
  })
  code: string;

  @ApiProperty({
    description: 'Nombre de la moneda',
    example: 'Dólar Estadounidense'
  })
  name: string;

  @ApiProperty({
    description: 'Símbolo de la moneda',
    example: '$'
  })
  symbol: string;

  @ApiProperty({
    description: 'Número de decimales',
    example: 2
  })
  precision: number;

  @ApiProperty({
    description: 'Separador de miles',
    example: ','
  })
  thousandSeparator: string;

  @ApiProperty({
    description: 'Separador decimal',
    example: '.'
  })
  decimalSeparator: string;

  @ApiProperty({
    description: 'Si la moneda está activa',
    example: true
  })
  isActive: boolean;

  @ApiProperty({
    description: 'Fecha de creación',
    example: '2025-06-12T17:17:50.594Z'
  })
  createdAt: Date;

  @ApiProperty({
    description: 'Fecha de última actualización',
    example: '2025-06-12T17:17:50.594Z'
  })
  updatedAt: Date;
}
