import { IsNotEmpty } from "class-validator";

export class SignInDto {
    @IsNotEmpty()
    crm_user_code: string;

    @IsNotEmpty()
    crm_user_password: string;
}