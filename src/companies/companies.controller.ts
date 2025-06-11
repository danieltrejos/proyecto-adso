import { Controller, Get, Post, Body, Patch, Param, Delete, ValidationPipe } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam } from '@nestjs/swagger';
import { CompaniesService } from './companies.service';
import { CreateCompanyDto } from './dto/create-company.dto';
import { UpdateCompanyDto } from './dto/update-company.dto';
import { Company } from './entities/company.entity';

@ApiTags('companies')
@Controller('companies')
export class CompaniesController {
  constructor(private readonly companiesService: CompaniesService) {}

  @Post()
  @ApiOperation({ summary: 'Crear una nueva empresa' })
  @ApiResponse({ status: 201, description: 'Empresa creada exitosamente', type: Company })
  @ApiResponse({ status: 409, description: 'Ya existe una empresa con este email' })
  create(@Body(ValidationPipe) createCompanyDto: CreateCompanyDto) {
    return this.companiesService.create(createCompanyDto);
  }

  @Get()
  @ApiOperation({ summary: 'Obtener todas las empresas' })
  @ApiResponse({ status: 200, description: 'Lista de empresas', type: [Company] })
  findAll() {
    return this.companiesService.findAll();
  }

  @Get('main')
  @ApiOperation({ summary: 'Obtener la empresa principal' })
  @ApiResponse({ status: 200, description: 'Empresa principal', type: Company })
  getMainCompany() {
    return this.companiesService.getMainCompany();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Obtener una empresa por ID' })
  @ApiParam({ name: 'id', description: 'ID de la empresa' })
  @ApiResponse({ status: 200, description: 'Empresa encontrada', type: Company })
  @ApiResponse({ status: 404, description: 'Empresa no encontrada' })
  findOne(@Param('id') id: string) {
    return this.companiesService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Actualizar una empresa' })
  @ApiParam({ name: 'id', description: 'ID de la empresa' })
  @ApiResponse({ status: 200, description: 'Empresa actualizada', type: Company })
  @ApiResponse({ status: 404, description: 'Empresa no encontrada' })
  @ApiResponse({ status: 409, description: 'Ya existe una empresa con este email' })
  update(@Param('id') id: string, @Body(ValidationPipe) updateCompanyDto: UpdateCompanyDto) {
    return this.companiesService.update(id, updateCompanyDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Eliminar una empresa' })
  @ApiParam({ name: 'id', description: 'ID de la empresa' })
  @ApiResponse({ status: 200, description: 'Empresa eliminada', type: Company })
  @ApiResponse({ status: 404, description: 'Empresa no encontrada' })
  remove(@Param('id') id: string) {
    return this.companiesService.remove(id);
  }
}
