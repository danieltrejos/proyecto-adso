import { IsOptional, IsString, IsNumber, IsDateString } from 'class-validator';
import { ApiPropertyOptional } from '@nestjs/swagger';

export class CreateInvoiceDto {
    @ApiPropertyOptional({
        description: 'ID de la venta para generar factura',
        example: 1
    })
    @IsOptional()
    @IsNumber()
    saleId?: number;
}

export class InvoiceQueryDto {
    @ApiPropertyOptional({
        description: 'Página para paginación',
        example: 1,
        default: 1
    })
    @IsOptional()
    @IsNumber()
    page?: number = 1;

    @ApiPropertyOptional({
        description: 'Límite de registros por página',
        example: 10,
        default: 10
    })
    @IsOptional()
    @IsNumber()
    limit?: number = 10;

    @ApiPropertyOptional({
        description: 'Filtrar por número de factura',
        example: 'FAC-00001'
    })
    @IsOptional()
    @IsString()
    invoiceNumber?: string;

    @ApiPropertyOptional({
        description: 'Filtrar por ID de cliente',
        example: 1
    })
    @IsOptional()
    @IsNumber()
    customerId?: number;

    @ApiPropertyOptional({
        description: 'Filtrar por ID de usuario',
        example: 1
    })
    @IsOptional()
    @IsNumber()
    userId?: number;

    @ApiPropertyOptional({
        description: 'Fecha de inicio para filtrar (formato: YYYY-MM-DD)',
        example: '2025-01-01'
    })
    @IsOptional()
    @IsDateString()
    startDate?: string;

    @ApiPropertyOptional({
        description: 'Fecha de fin para filtrar (formato: YYYY-MM-DD)',
        example: '2025-12-31'
    })
    @IsOptional()
    @IsDateString()
    endDate?: string;
}
