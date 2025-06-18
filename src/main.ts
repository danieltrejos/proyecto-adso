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
  try {
    // Debug de variables de entorno
    console.log('🔍 Environment Debug:');
    console.log('- NODE_ENV:', process.env.NODE_ENV);
    console.log('- DATABASE_URL exists:', !!process.env.DATABASE_URL);
    console.log('- DATABASE_URL length:', process.env.DATABASE_URL?.length || 0);
    console.log(
      '- All DATABASE vars:',
      Object.keys(process.env).filter((k) => k.includes('DATABASE'))
    );

    if (!process.env.DATABASE_URL) {
      console.error('❌ DATABASE_URL is missing!');
      console.log('Available env vars:', Object.keys(process.env).slice(0, 10));
      process.exit(1);
    }
    const app = await NestFactory.create(AppModule);

    app.use(morgan('dev'));

    const config = new DocumentBuilder()
      .setTitle('Brewsy API')
      .setDescription('Documentación de la API')
      .setVersion('1.0')
      .addTag('api')
      .build();
    const document = SwaggerModule.createDocument(app, config);
    SwaggerModule.setup('api', app, document);

    const configService = app.get(ConfigService);

    app.enableCors(CORS);
    app.setGlobalPrefix('api/v1');

    app.useGlobalPipes(
      new ValidationPipe({
        whitelist: true
      })
    );

    const port = process.env.PORT || configService.get('PORT') || 3000;

    await app.listen(port);
    console.log(`Application is running on port: ${port}`);
    console.log('NODE_ENV:', process.env.NODE_ENV);
    console.log('DATABASE_URL configured:', !!process.env.DATABASE_URL);
  } catch (error) {
    console.error('Failed to start application:', error);
    process.exit(1);
  }
}

bootstrap();
