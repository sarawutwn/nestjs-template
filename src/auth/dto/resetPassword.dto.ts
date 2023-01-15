import { IsNotEmpty } from "class-validator";

export class ResetPasswordDto {
    @IsNotEmpty()
    password: string;

    @IsNotEmpty()
    old_password: string;
}