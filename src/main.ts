import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as bodyParser from 'body-parser';

async function bootstrap() {
  const app = await NestFactory.create(AppModule, {cors: true});
  app.setGlobalPrefix('api');
  app.use(bodyParser.json({limit: '5mb'}));
  app.enableCors({
    origin: ["http://localhost:3000"],
    exposedHeaders: "*",
    methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
  });
  app.useGlobalPipes(new ValidationPipe());
  await app.listen(9999,'0.0.0.0');
}
bootstrap();
