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
import { ApiTags, ApiOperation, ApiResponse, ApiQuery } from '@nestjs/swagger';

@ApiTags('Sales')
@Controller('sales')
export class SalesController {
  constructor(private readonly salesService: SalesService) {}

  @Post()
  @ApiOperation({ summary: 'Crear una nueva venta' })
  @ApiResponse({ status: 201, description: 'Venta creada exitosamente.' })
  create(@Body(ValidationPipe) createSaleDto: CreateSaleDto) {
    return this.salesService.create(createSaleDto);
  }

  @Get()
  @ApiOperation({ summary: 'Obtener todas las ventas' })
  findAll() {
    return this.salesService.findAll();
  }

  @Get('report')
  @ApiOperation({ summary: 'Obtener reporte de ventas' })
  getSalesReport() {
    return this.salesService.getSalesReport();
  }

  @Get('user/:userId')
  @ApiOperation({ summary: 'Obtener ventas por usuario' })
  findByUser(@Param('userId', ParseIntPipe) userId: number) {
    return this.salesService.findByUser(userId);
  }

  @Get('date-range')
  @ApiOperation({ summary: 'Obtener ventas por rango de fechas' })
  @ApiQuery({ name: 'startDate', type: String })
  @ApiQuery({ name: 'endDate', type: String })
  findByDateRange(@Query('startDate') startDate: string, @Query('endDate') endDate: string) {
    return this.salesService.findByDateRange(new Date(startDate), new Date(endDate));
  }

  @Get(':id')
  @ApiOperation({ summary: 'Obtener una venta por ID' })
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.salesService.findOne(id);
  }
}
