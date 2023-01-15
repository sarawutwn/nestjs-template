import { Body, Controller, Post, Request, Response } from '@nestjs/common';
import { AuthService } from './auth.service';
import { CreateDto } from './dto/create.dto';
import { ResetPasswordDto } from './dto/resetPassword.dto';
import { SignInDto } from './dto/signIn.dto';

@Controller('auth')
export class AuthController {
    constructor(private authService: AuthService) {}

    @Post('/local/sign-up')
    signUpLocal(@Body() dto: CreateDto, @Body('crm_role_id') crm_role_id: string, @Request() req, @Response() res) {
        return this.authService.signUpLocal(dto, crm_role_id, req.user.crm_user_code, res);
    }

    @Post('/local/sign-in')
    signInLocal(@Body() dto: SignInDto, @Response() res) {
        return this.authService.signInLocal(dto, res);
    }

    @Post('/refresh-token')
    refreshToken(@Body('refresh_token') refresh: string, @Response() res) {
        return this.authService.refreshToken(refresh, res);
    }

    @Post('/local/sign-out')
    signOut(@Request() req, @Response() res) {
        return this.authService.signOut(req, res);
    }

    @Post('/reset-password')
    refreshTokens(@Body() dto: ResetPasswordDto, @Request() req, @Response() res) {
        return this.authService.resetPassword(dto, req.user.crm_user_id, res);
    }
}
