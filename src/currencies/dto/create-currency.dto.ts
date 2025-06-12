import {
  IsString,
  IsNumber,
  IsBoolean,
  IsOptional,
  IsNotEmpty,
  MinLength,
  MaxLength,
  Min,
  Max
} from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateCurrencyDto {
  @ApiProperty({
    description: 'Código de la moneda (ISO 4217)',
    example: 'USD',
    minLength: 3,
    maxLength: 3
  })
  @IsString()
  @IsNotEmpty()
  @MinLength(3)
  @MaxLength(3)
  code: string;

  @ApiProperty({
    description: 'Nombre de la moneda',
    example: 'Dólar Estadounidense'
  })
  @IsString()
  @IsNotEmpty()
  name: string;

  @ApiProperty({
    description: 'Símbolo de la moneda',
    example: '$'
  })
  @IsString()
  @IsNotEmpty()
  symbol: string;

  @ApiPropertyOptional({
    description: 'Número de decimales',
    example: 2,
    default: 2,
    minimum: 0,
    maximum: 4
  })
  @IsOptional()
  @IsNumber()
  @Min(0)
  @Max(4)
  precision?: number;

  @ApiPropertyOptional({
    description: 'Separador de miles',
    example: ',',
    default: ','
  })
  @IsOptional()
  @IsString()
  thousandSeparator?: string;

  @ApiPropertyOptional({
    description: 'Separador decimal',
    example: '.',
    default: '.'
  })
  @IsOptional()
  @IsString()
  decimalSeparator?: string;

  @ApiPropertyOptional({
    description: 'Si la moneda está activa',
    example: true,
    default: true
  })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;
}
