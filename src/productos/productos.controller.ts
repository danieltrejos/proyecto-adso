import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  ParseIntPipe,
  ValidationPipe
} from '@nestjs/common';
import { ProductosService } from './productos.service';
import { CreateProductoDto } from './dto/create-producto.dto';
import { UpdateProductoDto } from './dto/update-producto.dto';
import { ApiExcludeController } from '@nestjs/swagger';

@ApiExcludeController()
@Controller('productos')
export class ProductosController {
  constructor(private readonly productosService: ProductosService) {}

  @Get() //! Get /productos
  findAll() {
    return this.productosService.findAll();
  }

  @Get(':id') //! Get /productos/:id
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.productosService.findOne(id);
  }

  @Post() //! Post /productos
  create(@Body(ValidationPipe) createProductoDto: CreateProductoDto) {
    console.log(createProductoDto); // El contenido del body se almacena como dto -> y se manda al servicio
    return this.productosService.create(createProductoDto);
  }

  @Patch(':id') //! Path /productos/:id
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body(ValidationPipe) updateProductoDto: UpdateProductoDto
  ) {
    return this.productosService.update(id, updateProductoDto);
  }

  @Delete(':id') //! Delete /productos/:id
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.productosService.remove(id);
  }
}
