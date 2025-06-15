import { IsOptional, IsString, IsNumber, Min, Max } from 'class-validator';
import { Type } from 'class-transformer';
import { ApiPropertyOptional } from '@nestjs/swagger';

export class GetProductsDto {
    @ApiPropertyOptional({
        description: 'Página para paginación',
        example: 1,
        default: 1
    })
    @IsOptional()
    @Type(() => Number)
    @IsNumber()
    @Min(1)
    page?: number = 1;

    @ApiPropertyOptional({
        description: 'Límite de registros por página',
        example: 10,
        default: 10
    })
    @IsOptional()
    @Type(() => Number)
    @IsNumber()
    @Min(1)
    @Max(100)
    limit?: number = 10;

    @ApiPropertyOptional({
        description: 'Filtrar por nombre del producto',
        example: 'Corona'
    })
    @IsOptional()
    @IsString()
    name?: string;

    @ApiPropertyOptional({
        description: 'Filtrar por tipo de producto',
        example: 'Lager'
    })
    @IsOptional()
    @IsString()
    type?: string;

    @ApiPropertyOptional({
        description: 'Precio mínimo para filtrar',
        example: 1000
    })
    @IsOptional()
    @Type(() => Number)
    @IsNumber()
    @Min(0)
    minPrice?: number;

    @ApiPropertyOptional({
        description: 'Precio máximo para filtrar',
        example: 10000
    })
    @IsOptional()
    @Type(() => Number)
    @IsNumber()
    @Min(0)
    maxPrice?: number; @ApiPropertyOptional({
        description: 'Stock mínimo para filtrar',
        example: 0
    })
    @IsOptional()
    @Type(() => Number)
    @IsNumber()
    @Min(0)
    minStock?: number;

    @ApiPropertyOptional({
        description: 'Obtener todos los productos sin paginación',
        example: false,
        default: false
    })
    @IsOptional()
    @Type(() => Boolean)
    all?: boolean = false;
}
