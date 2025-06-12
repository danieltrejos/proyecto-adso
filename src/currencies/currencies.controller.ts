import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  ValidationPipe,
  ParseIntPipe
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam, ApiBody } from '@nestjs/swagger';
import { CurrenciesService } from './currencies.service';
import { CreateCurrencyDto } from './dto/create-currency.dto';
import { UpdateCurrencyDto } from './dto/update-currency.dto';
import { Currency } from './entities/currency.entity';

@ApiTags('Currencies')
@Controller('currencies')
export class CurrenciesController {
  constructor(private readonly currenciesService: CurrenciesService) {}

  @Post()
  @ApiOperation({ summary: 'Crear una nueva moneda' })
  @ApiBody({ type: CreateCurrencyDto })
  @ApiResponse({ status: 201, description: 'Moneda creada exitosamente.', type: Currency })
  @ApiResponse({ status: 400, description: 'Datos inválidos.' })
  @ApiResponse({ status: 409, description: 'Ya existe una moneda con este código.' })
  create(@Body(ValidationPipe) createCurrencyDto: CreateCurrencyDto) {
    return this.currenciesService.create(createCurrencyDto);
  }

  @Get()
  @ApiOperation({ summary: 'Obtener todas las monedas' })
  @ApiResponse({
    status: 200,
    description: 'Lista de monedas obtenida exitosamente.',
    type: [Currency]
  })
  findAll() {
    return this.currenciesService.findAll();
  }

  @Get('active')
  @ApiOperation({ summary: 'Obtener monedas activas' })
  @ApiResponse({
    status: 200,
    description: 'Lista de monedas activas obtenida exitosamente.',
    type: [Currency]
  })
  findActive() {
    return this.currenciesService.findActive();
  }

  @Get('code/:code')
  @ApiOperation({ summary: 'Obtener moneda por código' })
  @ApiParam({ name: 'code', description: 'Código de la moneda (ISO 4217)', example: 'USD' })
  @ApiResponse({ status: 200, description: 'Moneda encontrada exitosamente.', type: Currency })
  @ApiResponse({ status: 404, description: 'Moneda no encontrada.' })
  findByCode(@Param('code') code: string) {
    return this.currenciesService.findByCode(code);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Obtener una moneda por ID' })
  @ApiParam({ name: 'id', description: 'ID de la moneda', type: 'number' })
  @ApiResponse({ status: 200, description: 'Moneda encontrada exitosamente.', type: Currency })
  @ApiResponse({ status: 404, description: 'Moneda no encontrada.' })
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.currenciesService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Actualizar una moneda' })
  @ApiParam({ name: 'id', description: 'ID de la moneda', type: 'number' })
  @ApiBody({ type: UpdateCurrencyDto })
  @ApiResponse({ status: 200, description: 'Moneda actualizada exitosamente.', type: Currency })
  @ApiResponse({ status: 404, description: 'Moneda no encontrada.' })
  @ApiResponse({ status: 409, description: 'Ya existe una moneda con este código.' })
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body(ValidationPipe) updateCurrencyDto: UpdateCurrencyDto
  ) {
    return this.currenciesService.update(id, updateCurrencyDto);
  }

  @Patch(':id/activate')
  @ApiOperation({ summary: 'Activar una moneda' })
  @ApiParam({ name: 'id', description: 'ID de la moneda', type: 'number' })
  @ApiResponse({ status: 200, description: 'Moneda activada exitosamente.', type: Currency })
  @ApiResponse({ status: 404, description: 'Moneda no encontrada.' })
  activate(@Param('id', ParseIntPipe) id: number) {
    return this.currenciesService.activate(id);
  }

  @Patch(':id/deactivate')
  @ApiOperation({ summary: 'Desactivar una moneda' })
  @ApiParam({ name: 'id', description: 'ID de la moneda', type: 'number' })
  @ApiResponse({ status: 200, description: 'Moneda desactivada exitosamente.', type: Currency })
  @ApiResponse({ status: 404, description: 'Moneda no encontrada.' })
  @ApiResponse({ status: 409, description: 'No se puede desactivar la única moneda activa.' })
  deactivate(@Param('id', ParseIntPipe) id: number) {
    return this.currenciesService.deactivate(id);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Eliminar una moneda' })
  @ApiParam({ name: 'id', description: 'ID de la moneda', type: 'number' })
  @ApiResponse({ status: 200, description: 'Moneda eliminada exitosamente.' })
  @ApiResponse({ status: 404, description: 'Moneda no encontrada.' })
  @ApiResponse({
    status: 409,
    description: 'No se puede eliminar la moneda porque está siendo utilizada.'
  })
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.currenciesService.remove(id);
  }
}
