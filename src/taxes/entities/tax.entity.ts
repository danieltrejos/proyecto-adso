import { ApiProperty } from '@nestjs/swagger';

export class Tax {
  @ApiProperty({
    description: 'ID único del impuesto',
    example: 1
  })
  id: number;

  @ApiProperty({
    description: 'Nombre del impuesto',
    example: 'IVA'
  })
  name: string;

  @ApiProperty({
    description: 'Porcentaje del impuesto',
    example: 10.0
  })
  rate: number;

  @ApiProperty({
    description: 'Si el impuesto está activo',
    example: true
  })
  isActive: boolean;

  @ApiProperty({
    description: 'Si es el impuesto por defecto',
    example: true
  })
  isDefault: boolean;

  @ApiProperty({
    description: 'Fecha de creación',
    example: '2025-06-12T17:15:58.498Z'
  })
  createdAt: Date;

  @ApiProperty({
    description: 'Fecha de última actualización',
    example: '2025-06-12T17:15:58.498Z'
  })
  updatedAt: Date;
}
