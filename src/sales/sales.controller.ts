import {
  Controller,
  Get,
  Post,
  Body,
  // Patch,
  Param,
  // Delete,
  ParseIntPipe,
  ValidationPipe,
  Query
} from '@nestjs/common';
import { SalesService } from './sales.service';
import { CreateSaleDto } from './dto/create-sale.dto';
//import { UpdateSaleDto } from './dto/update-sale.dto';
import { ApiTags, ApiOperation, ApiResponse, ApiQuery, ApiParam, ApiBody } from '@nestjs/swagger';

@ApiTags('Sales')
@Controller('sales')
export class SalesController {
  constructor(private readonly salesService: SalesService) {}
  @Post()
  @ApiOperation({ summary: 'Crear una nueva venta' })
  @ApiBody({ type: CreateSaleDto })
  @ApiResponse({ status: 201, description: 'Venta creada exitosamente.' })
  @ApiResponse({ status: 400, description: 'Datos inválidos o stock insuficiente.' })
  create(@Body(ValidationPipe) createSaleDto: CreateSaleDto) {
    return this.salesService.create(createSaleDto);
  }

  @Get()
  @ApiOperation({ summary: 'Obtener todas las ventas' })
  @ApiResponse({ status: 200, description: 'Lista de ventas obtenida exitosamente.' })
  findAll() {
    return this.salesService.findAll();
  }

  @Get('report')
  @ApiOperation({ summary: 'Obtener reporte de ventas' })
  @ApiResponse({ status: 200, description: 'Reporte de ventas obtenido exitosamente.' })
  getSalesReport() {
    return this.salesService.getSalesReport();
  }

  @Get('user/:userId')
  @ApiOperation({ summary: 'Obtener ventas por usuario' })
  @ApiParam({ name: 'userId', description: 'ID del usuario', type: 'number' })
  @ApiResponse({ status: 200, description: 'Ventas del usuario obtenidas exitosamente.' })
  @ApiResponse({ status: 404, description: 'Usuario no encontrado.' })
  findByUser(@Param('userId', ParseIntPipe) userId: number) {
    return this.salesService.findByUser(userId);
  }

  @Get('date-range')
  @ApiOperation({ summary: 'Obtener ventas por rango de fechas' })
  @ApiQuery({
    name: 'startDate',
    type: String,
    description: 'Fecha de inicio (YYYY-MM-DD)',
    example: '2025-01-01'
  })
  @ApiQuery({
    name: 'endDate',
    type: String,
    description: 'Fecha de fin (YYYY-MM-DD)',
    example: '2025-12-31'
  })
  @ApiResponse({ status: 200, description: 'Ventas en el rango de fechas obtenidas exitosamente.' })
  @ApiResponse({ status: 400, description: 'Formato de fecha inválido.' })
  findByDateRange(@Query('startDate') startDate: string, @Query('endDate') endDate: string) {
    return this.salesService.findByDateRange(new Date(startDate), new Date(endDate));
  }

  @Get(':id')
  @ApiOperation({ summary: 'Obtener una venta por ID' })
  @ApiParam({ name: 'id', description: 'ID de la venta', type: 'number' })
  @ApiResponse({ status: 200, description: 'Venta encontrada exitosamente.' })
  @ApiResponse({ status: 404, description: 'Venta no encontrada.' })
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.salesService.findOne(id);
  }
}
