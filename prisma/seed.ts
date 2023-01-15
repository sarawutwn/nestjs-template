import { crm_roles } from './seeds/crm_role';
import { PrismaClient } from '@prisma/client';
import { crm_users } from './seeds/crm_user';
import { crm_permissions } from './seeds/crm_permission';
import { crm_permission_components } from './seeds/crm_permission_component';
import { crm_branchs } from './seeds/crm_branchs';
import { crm_reward } from './seeds/crm_reward';
import { crm_quota } from './seeds/crm_quota';
import { crm_points } from './seeds/crm_points';
import { crm_point_branchs } from './seeds/crm_point_branchs';
import { point_adjustment } from './seeds/crm_point_adjustment';
import { crm_customer } from './seeds/crm_customer';
import { crm_customer_points } from './seeds/crm_customer_points';
import { crm_customer_level } from './seeds/crm_customer_level';

const prisma = new PrismaClient();

async function main() {
  await prisma.crm_branchs.createMany({ data: crm_branchs });
  await prisma.crm_roles.createMany({ data: crm_roles });
  await prisma.crm_users.createMany({ data: crm_users });
  await prisma.crm_permissions.createMany({ data: crm_permissions });
  await prisma.crm_points.createMany({ data: crm_points });
  await prisma.crm_permission_components.createMany({ data: crm_permission_components });
  await prisma.crm_reward.createMany({ data: crm_reward });
  await prisma.crm_quota.createMany({ data: crm_quota });
  await prisma.crm_point_adjustments.createMany({ data: point_adjustment });
  await prisma.crm_point_branchs.createMany({ data: crm_point_branchs });
  await prisma.crm_customers.createMany({ data: crm_customer });
  await prisma.crm_customer_points.createMany({ data: crm_customer_points });
  await prisma.crm_customer_levels.createMany({ data: crm_customer_level });
}

main()
  .catch((e) => {
    console.log(e);
    process.exit(1);
  })
  .finally(() => {
    prisma.$disconnect();
  });
