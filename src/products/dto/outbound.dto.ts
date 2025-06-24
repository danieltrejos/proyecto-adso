import { IsNumber, IsPositive, Min } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class OutboundDto {
  @ApiProperty({
    description: 'Cantidad a reducir del stock',
    example: 10,
    minimum: 1
  })
  @IsNumber({}, { message: 'La cantidad debe ser un número' })
  @IsPositive({ message: 'La cantidad debe ser positiva' })
  @Min(1, { message: 'La cantidad debe ser mayor a 0' })
  amount: number;
}
