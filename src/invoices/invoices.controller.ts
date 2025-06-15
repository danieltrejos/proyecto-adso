import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  Res,
  HttpStatus,
  ParseIntPipe
} from '@nestjs/common';
import { Response } from 'express';
import { InvoicesService } from './invoices.service';
import { CreateInvoiceDto, InvoiceQueryDto } from './dto/create-invoice.dto';
import { UpdateInvoiceDto } from './dto/update-invoice.dto';
import { ApiTags, ApiOperation, ApiResponse, ApiParam, ApiQuery } from '@nestjs/swagger';

@ApiTags('invoices')
@Controller('invoices')
export class InvoicesController {
  constructor(private readonly invoicesService: InvoicesService) { }

  @Post()
  @ApiOperation({ summary: 'Crear/generar una factura basada en una venta' })
  @ApiResponse({ status: 201, description: 'Factura generada exitosamente' })
  @ApiResponse({ status: 400, description: 'ID de venta requerido' })
  @ApiResponse({ status: 404, description: 'Venta no encontrada' })
  create(@Body() createInvoiceDto: CreateInvoiceDto) {
    return this.invoicesService.create(createInvoiceDto);
  }

  @Get()
  @ApiOperation({ summary: 'Obtener listado de facturas con paginación y filtros' })
  @ApiQuery({ name: 'page', required: false, description: 'Número de página' })
  @ApiQuery({ name: 'limit', required: false, description: 'Registros por página' })
  @ApiQuery({ name: 'invoiceNumber', required: false, description: 'Filtrar por número de factura' })
  @ApiQuery({ name: 'customerId', required: false, description: 'Filtrar por ID de cliente' })
  @ApiQuery({ name: 'userId', required: false, description: 'Filtrar por ID de usuario' })
  @ApiQuery({ name: 'startDate', required: false, description: 'Fecha de inicio (YYYY-MM-DD)' })
  @ApiQuery({ name: 'endDate', required: false, description: 'Fecha de fin (YYYY-MM-DD)' })
  @ApiResponse({ status: 200, description: 'Lista de facturas obtenida exitosamente' })
  findAll(@Query() query: InvoiceQueryDto) {
    return this.invoicesService.findAll(query);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Obtener una factura por ID de venta' })
  @ApiParam({ name: 'id', description: 'ID de la venta' })
  @ApiResponse({ status: 200, description: 'Factura encontrada' })
  @ApiResponse({ status: 404, description: 'Factura no encontrada' })
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.invoicesService.findOne(id);
  }

  @Get(':id/download')
  @ApiOperation({ summary: 'Descargar factura en formato PDF' })
  @ApiParam({ name: 'id', description: 'ID de la venta' })
  @ApiResponse({
    status: 200,
    description: 'PDF de factura generado exitosamente',
    headers: {
      'Content-Type': { description: 'application/pdf' },
      'Content-Disposition': { description: 'attachment; filename="factura-{invoiceNumber}.pdf"' }
    }
  })
  @ApiResponse({ status: 404, description: 'Factura no encontrada' })
  async downloadPDF(
    @Param('id', ParseIntPipe) id: number,
    @Res() res: Response
  ) {
    try {
      const invoice = await this.invoicesService.findOne(id);
      const pdfBuffer = await this.invoicesService.downloadPDF(id);

      res.set({
        'Content-Type': 'application/pdf',
        'Content-Disposition': `attachment; filename="factura-${invoice.invoiceNumber}.pdf"`,
        'Content-Length': pdfBuffer.length.toString(),
      });

      res.status(HttpStatus.OK).send(pdfBuffer);
    } catch (error) {
      res.status(HttpStatus.INTERNAL_SERVER_ERROR).json({
        message: 'Error al generar PDF',
        error: error instanceof Error ? error.message : 'Error desconocido'
      });
    }
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Actualizar una factura (No permitido)' })
  @ApiResponse({ status: 400, description: 'Las facturas no pueden ser modificadas' })
  update(@Param('id', ParseIntPipe) id: number, @Body() updateInvoiceDto: UpdateInvoiceDto) {
    return this.invoicesService.update(id, updateInvoiceDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Eliminar una factura (No permitido)' })
  @ApiResponse({ status: 400, description: 'Las facturas no pueden ser eliminadas' })
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.invoicesService.remove(id);
  }
}
