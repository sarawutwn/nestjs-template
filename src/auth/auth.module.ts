import { Module } from '@nestjs/common';
import { BcryptUtils } from 'src/global/bcrypt/encode';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';

@Module({
  controllers: [AuthController],
  providers: [AuthService, BcryptUtils]
})
export class AuthModule {}
