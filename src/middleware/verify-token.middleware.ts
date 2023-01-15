import { Injectable, NestMiddleware, createParamDecorator, ExecutionContext } from '@nestjs/common';
import { Request, Response, NextFunction, response } from 'express';
import { BcryptUtils } from 'src/global/bcrypt/encode';

@Injectable()
export class VerifyToken implements NestMiddleware {
  constructor(private bcryptUtils: BcryptUtils) {}
  async use(req: Request, res: Response, next: NextFunction) {
    if (req.headers.authorization === undefined) {
      res.status(401).json({ status: 'UnAutholization', message: 'Token is undefined!' });
      return;
    }
    if (req.headers.authorization &&req.headers.authorization.split(' ')[0] === 'Bearer') {
      try {
        let payload = await this.bcryptUtils.deCode(req.headers.authorization.split(' ')[1]);
        req['user'] = payload;
        next();
      } catch (err) {
        res.status(401).json({ status: 'UnAutholization', message: err });
      }
    } else {
      res.status(401).json({ status: 'UnAutholization', message: 'Token invalid!' });
      return;
    }
  }
}


