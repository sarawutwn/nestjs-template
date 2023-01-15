import { MiddlewareConsumer, Module, NestModule, RequestMethod } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { PrismaModule } from './prisma/prisma.module';
import { VerifyToken } from './middleware/verify-token.middleware';
import { BcryptUtils } from './global/bcrypt/encode';

@Module({
  imports: [AuthModule, PrismaModule, AppModule],
  providers: [BcryptUtils],
  controllers: [],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(VerifyToken).exclude(
      { path: 'api/auth/local/sign-in', method: RequestMethod.POST },
      { path: 'api/auth/refresh-token', method: RequestMethod.POST },
    ).forRoutes('*');
  }
}
