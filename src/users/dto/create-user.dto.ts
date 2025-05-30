import { IsString, IsNotEmpty, IsEmail, IsOptional } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateUserDto {
  @ApiProperty({ description: 'Nombre del usuario', example: 'Juan Pérez' })
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiProperty({ description: 'Email del usuario', example: 'juan@example.com' })
  @IsNotEmpty()
  @IsEmail()
  email: string;

  @ApiPropertyOptional({ description: 'Rol del usuario', example: 'bartender' })
  @IsOptional()
  @IsString()
  role?: string;
}
