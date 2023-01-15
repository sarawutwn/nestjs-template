import { IsEmail, IsNotEmpty, IsNumber } from "class-validator";

export class CreateDto {
    @IsNotEmpty()
    crm_user_code: string;

    @IsEmail()
    crm_user_email: string;

    @IsNotEmpty()
    crm_user_password: string;

    @IsNotEmpty()
    crm_user_firstname: string;

    @IsNotEmpty()
    crm_user_lastname: string;

    @IsNotEmpty()
    crm_user_telephone: string;

    @IsNotEmpty()
    crm_role_id: string;

    @IsNotEmpty()
    crm_branch_id: number;
}