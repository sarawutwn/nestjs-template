import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateDto } from './dto/create.dto';
import { BcryptUtils } from 'src/global/bcrypt/encode';
import { SignInDto } from './dto/signIn.dto';
import { ResetPasswordDto } from './dto/resetPassword.dto';

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private bcryptUtils: BcryptUtils,
  ) {}

  async signUpLocal(dto: CreateDto, crm_role_id: string, crm_user_code: string, res) {
    const oldUser = await this.prisma.crm_users.findMany({
      where: {
        crm_user_email: dto.crm_user_email,
        crm_user_code: dto.crm_user_code,
      },
    });
    if (oldUser.length !== 0) return res.status(405).json({status: "fail",message: 'User already has!',})
    const hash = await this.bcryptUtils.hashData(dto.crm_user_password);
    const result = await this.prisma.crm_users.create({
      data: {
        crm_user_code: dto.crm_user_code,
        crm_user_email: dto.crm_user_email,
        crm_user_password: hash.toString(),
        crm_user_firstname: dto.crm_user_firstname,
        crm_user_lastname: dto.crm_user_lastname,
        crm_user_telephone: dto.crm_user_telephone,
        createdBy: crm_user_code,
        crm_role: {
          connect: { crm_role_id: dto.crm_role_id },
        },
        crm_branch: {
          connect: { crm_branch_id: dto.crm_branch_id }
        }
      },
    });
    res.json({ status: 'success', result });
  }

  async signInLocal(dto: SignInDto, res) {
    try {
      const result = await this.prisma.crm_users.findUnique({
        where: { crm_user_code: dto.crm_user_code },
        include: {
          crm_user_logger: true,
          crm_role: {
            select: {
              crm_role_name: true,
              crm_role_display_name: true,
              crm_permission_group: {
                select: {
                  activate: true,
                  crm_permission_components: {
                    select: {
                      crm_permission_component_name: true,
                    }
                  },
                  crm_permissions: {
                    select: {
                      crm_permission_name: true
                    }
                  }
                }
              }
            }
          },
        }
      });
      if (result === null) return res.status(401).json({ status: "fail", message: "UnAuthenticated"});
      if (result.crm_user_logger.length > 3) {
        return res.status(401).json({ status: "fail", message: "This user is locked!"});
      }
      if (await this.bcryptUtils.compareData(dto.crm_user_password,result.crm_user_password)) {
        const user_profile = {
          crm_user_id: result.crm_user_id,
          crm_user_code: result.crm_user_code,
          crm_user_firstname: result.crm_user_firstname,
          crm_user_lastname: result.crm_user_lastname,
          crm_branch_id: result.crm_branch_id,
        };
        const role = {
          crm_role_id: result.crm_role_id,
          crm_role_name: result.crm_role.crm_role_name,
          crm_role_display_name: result.crm_role.crm_role_display_name
        }
        let permission = [];
        let component = [];
        await result.crm_role.crm_permission_group.forEach(element => {
          let filter = permission.findIndex(item => item === element.crm_permissions.crm_permission_name);
            if(filter === -1) {
              permission.push(element.crm_permissions.crm_permission_name);
            }
            if(element.activate === true) {
              component.push(element.crm_permission_components.crm_permission_component_name);
            }
        })
        const token = await this.bcryptUtils.jwtEncode(user_profile);
        const refreshToken = await this.bcryptUtils.refreshJwtEndcode(user_profile);
        await this.prisma.crm_users.update({ where: { crm_user_id: result.crm_user_id }, data: { refresh_token: refreshToken } });
        await this.prisma.crm_user_logger.deleteMany({ where: { crm_user_id: result.crm_user_id }});
        return res.json({ status: 'Authenticated', user_profile, token, refreshToken, role, component, permission });
      } else {
        await this.prisma.crm_user_logger.create({ data: {crm_login_status: "UnAuthenticated", crm_users: {connect: {crm_user_id: result.crm_user_id}}}});
        return res.status(401).json({ status: "UnAuthenticated", message: "Password not compare!"});
      }
    } catch (err) {
      return err;
    }
  }

  async refreshToken(refresh_token:string, res) {
    try {
      const payload = await this.bcryptUtils.refreshTokenSign(refresh_token);
      const result = await this.prisma.crm_users.findUnique({ where: {crm_user_id: payload['crm_user_id'] }});
      if(result === null) {
        res.status(403).json({ status: "UnAutholization" });
        return;
      }
      if(refresh_token !== result.refresh_token) {
        res.status(403).json({ status: "UnAutholization" });
        return;
      }
      const user_profile = {
        crm_user_id: result.crm_user_id,
        crm_user_code: result.crm_user_code,
        crm_user_firstname: result.crm_user_firstname,
        crm_user_lastname: result.crm_user_lastname,
        crm_branch_id: result.crm_branch_id,
      };
      const token = await this.bcryptUtils.jwtEncode(user_profile);
      res.json({ status: "success", token });
    }catch(err) {
      res.status(500).json({ status: "UnAutholization", error: err.message });
    }
  }

  async signOut(req, res) {
    try {
      await this.prisma.crm_users.update({
        where: {
          crm_user_id: req.user['crm_user_id'],
        },
        data: {
          refresh_token: null
        }
      });
      res.json({ status: "success" });
    }catch(err) {
      res.status(500).json({ error: err.message });;
    }
  }

  async resetPassword(dto: ResetPasswordDto, crm_user_id: number, res) {
    try {
      const userData = await this.prisma.crm_users.findMany({ where: {crm_user_id: crm_user_id}});
      if(userData.length === 0) {
        res.status(404).json({ status: "error", message: "Not found this user!" });
        return;
      }
      if(await this.bcryptUtils.compareData(dto.old_password, userData[0].crm_user_password)) {
        let hash = await this.bcryptUtils.hashData(dto.password);
        await this.prisma.crm_users.update({ where: { crm_user_id: crm_user_id }, data: { crm_user_password: hash }});
        res.json({ status: "success" });
      }else {
        res.status(400).json({ status: "fail", message: "Old password is wrong!"});
        return;
      }
    }catch(err) {
      res.status(500).json({ error: err.message });
    }
  }
}
