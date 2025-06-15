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
import { TaxesService } from './taxes.service';
import { CreateTaxDto } from './dto/create-tax.dto';
import { UpdateTaxDto } from './dto/update-tax.dto';
import { Tax } from './entities/tax.entity';

@ApiTags('Taxes')
@Controller('taxes')
export class TaxesController {
  constructor(private readonly taxesService: TaxesService) {}

  @Post()
  @ApiOperation({ summary: 'Crear un nuevo impuesto' })
  @ApiBody({ type: CreateTaxDto })
  @ApiResponse({ status: 201, description: 'Impuesto creado exitosamente.', type: Tax })
  @ApiResponse({ status: 400, description: 'Datos inválidos.' })
  create(@Body(ValidationPipe) createTaxDto: CreateTaxDto) {
    return this.taxesService.create(createTaxDto);
  }

  @Get()
  @ApiOperation({ summary: 'Obtener todos los impuestos' })
  @ApiResponse({
    status: 200,
    description: 'Lista de impuestos obtenida exitosamente.',
    type: [Tax]
  })
  findAll() {
    return this.taxesService.findAll();
  }

  @Get('active')
  @ApiOperation({ summary: 'Obtener impuestos activos' })
  @ApiResponse({
    status: 200,
    description: 'Lista de impuestos activos obtenida exitosamente.',
    type: [Tax]
  })
  findActive() {
    return this.taxesService.findActive();
  }

  @Get('default')
  @ApiOperation({ summary: 'Obtener el impuesto por defecto' })
  @ApiResponse({
    status: 200,
    description: 'Impuesto por defecto obtenido exitosamente.',
    type: Tax
  })
  @ApiResponse({ status: 404, description: 'No hay impuesto por defecto configurado.' })
  findDefault() {
    return this.taxesService.findDefault();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Obtener un impuesto por ID' })
  @ApiParam({ name: 'id', description: 'ID del impuesto', type: 'number' })
  @ApiResponse({ status: 200, description: 'Impuesto encontrado exitosamente.', type: Tax })
  @ApiResponse({ status: 404, description: 'Impuesto no encontrado.' })
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.taxesService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Actualizar un impuesto' })
  @ApiParam({ name: 'id', description: 'ID del impuesto', type: 'number' })
  @ApiBody({ type: UpdateTaxDto })
  @ApiResponse({ status: 200, description: 'Impuesto actualizado exitosamente.', type: Tax })
  @ApiResponse({ status: 404, description: 'Impuesto no encontrado.' })
  update(@Param('id', ParseIntPipe) id: number, @Body(ValidationPipe) updateTaxDto: UpdateTaxDto) {
    return this.taxesService.update(id, updateTaxDto);
  }

  @Patch(':id/set-default')
  @ApiOperation({ summary: 'Establecer impuesto como por defecto' })
  @ApiParam({ name: 'id', description: 'ID del impuesto', type: 'number' })
  @ApiResponse({
    status: 200,
    description: 'Impuesto establecido como por defecto exitosamente.',
    type: Tax
  })
  @ApiResponse({ status: 404, description: 'Impuesto no encontrado.' })
  setDefault(@Param('id', ParseIntPipe) id: number) {
    return this.taxesService.setDefault(id);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Eliminar un impuesto' })
  @ApiParam({ name: 'id', description: 'ID del impuesto', type: 'number' })
  @ApiResponse({ status: 200, description: 'Impuesto eliminado exitosamente.' })
  @ApiResponse({ status: 404, description: 'Impuesto no encontrado.' })
  @ApiResponse({
    status: 409,
    description: 'No se puede eliminar el único impuesto activo por defecto.'
  })
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.taxesService.remove(id);
  }
}
