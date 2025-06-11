import { IsString, IsEmail, IsOptional, IsNotEmpty } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateCompanyDto {
  @ApiProperty({ description: 'Nombre de la empresa' })
  @IsString()
  @IsNotEmpty()
  name: string;

  @ApiProperty({ description: 'Número de registro de la empresa' })
  @IsString()
  @IsNotEmpty()
  registrationNumber: string;

  @ApiProperty({ description: 'Correo electrónico de la empresa' })
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @ApiPropertyOptional({ description: 'Teléfono de la empresa' })
  @IsString()
  @IsOptional()
  phone?: string;

  @ApiPropertyOptional({ description: 'Moneda utilizada', default: 'USD' })
  @IsString()
  @IsOptional()
  currency?: string;

  @ApiPropertyOptional({ description: 'Zona horaria', default: 'America/Bogota' })
  @IsString()
  @IsOptional()
  timezone?: string;

  @ApiPropertyOptional({ description: 'Logo de la empresa (URL o path)' })
  @IsString()
  @IsOptional()
  logo?: string;

  @ApiProperty({ description: 'Dirección completa' })
  @IsString()
  @IsNotEmpty()
  street: string;

  @ApiProperty({ description: 'Ciudad' })
  @IsString()
  @IsNotEmpty()
  city: string;

  @ApiProperty({ description: 'Estado/Región/Provincia' })
  @IsString()
  @IsNotEmpty()
  state: string;

  @ApiProperty({ description: 'Código postal' })
  @IsString()
  @IsNotEmpty()
  postalCode: string;

  @ApiProperty({ description: 'País' })
  @IsString()
  @IsNotEmpty()
  country: string;
}
