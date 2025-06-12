import {
  IsString,
  IsNumber,
  IsBoolean,
  IsOptional,
  IsNotEmpty,
  IsPositive,
  Min,
  Max
} from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateTaxDto {
  @ApiProperty({
    description: 'Nombre del impuesto',
    example: 'IVA'
  })
  @IsString()
  @IsNotEmpty()
  name: string;

  @ApiProperty({
    description: 'Porcentaje del impuesto (0-100)',
    example: 10.0,
    minimum: 0,
    maximum: 100
  })
  @IsNumber()
  @IsPositive()
  @Min(0)
  @Max(100)
  rate: number;

  @ApiPropertyOptional({
    description: 'Si el impuesto está activo',
    example: true,
    default: true
  })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;

  @ApiPropertyOptional({
    description: 'Si es el impuesto por defecto',
    example: false,
    default: false
  })
  @IsOptional()
  @IsBoolean()
  isDefault?: boolean;
}
