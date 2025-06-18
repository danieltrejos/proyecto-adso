/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-floating-promises */
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as morgan from 'morgan';
import { CORS } from './constants';

import { ConfigService } from '@nestjs/config';

import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { ValidationPipe } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  //!Morgan
  app.use(morgan('dev'));

  //!Configuración de Swagger
  const config = new DocumentBuilder()
    .setTitle('Brewsy API')
    .setDescription('Documentación de la API')
    .setVersion('1.0')
    .addTag('api')
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document);

  const configService = app.get(ConfigService); // configService.get('PORT')

  // CORS
  app.enableCors(CORS);
  app.setGlobalPrefix('api/v1'); // Prefijo para todas las rutas de la API

  app.useGlobalPipes(
    new ValidationPipe({
      // Validación de datos de entrada
      whitelist: true // Elimina propiedades no definidas en el DTO
    })
  );

  // Priorizar PORT del entorno (Render lo provee automáticamente)
  // Luego ConfigService, y finalmente 8000 por defecto
  const port = process.env.PORT || configService.get('PORT') || 8001;
  await app.listen(port);
  console.log(`Application is running on port: ${port}`);
  console.log('NODE_ENV:', process.env.NODE_ENV);
}
bootstrap();
