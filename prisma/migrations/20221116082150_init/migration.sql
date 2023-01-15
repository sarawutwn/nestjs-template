-- CreateTable
CREATE TABLE "crm_users" (
    "crm_user_id" SERIAL NOT NULL,
    "crm_user_code" TEXT NOT NULL,
    "crm_user_email" TEXT NOT NULL,
    "crm_user_password" TEXT NOT NULL,
    "crm_user_firstname" TEXT NOT NULL,
    "crm_user_lastname" TEXT NOT NULL,
    "crm_user_telephone" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "createdBy" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "refresh_token" TEXT,
    "crm_role_id" TEXT NOT NULL,
    "crm_branch_id" INTEGER NOT NULL,

    CONSTRAINT "crm_users_pkey" PRIMARY KEY ("crm_user_id")
);

-- CreateTable
CREATE TABLE "crm_user_logger" (
    "crm_user_logger_id" SERIAL NOT NULL,
    "crm_login_status" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "crm_user_id" INTEGER NOT NULL,

    CONSTRAINT "crm_user_logger_pkey" PRIMARY KEY ("crm_user_logger_id")
);

-- CreateTable
CREATE TABLE "crm_roles" (
    "crm_role_id" TEXT NOT NULL,
    "crm_role_name" TEXT NOT NULL,
    "crm_role_display_name" TEXT NOT NULL,
    "crm_role_description" TEXT NOT NULL,
    "status" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "crm_roles_pkey" PRIMARY KEY ("crm_role_id")
);

-- CreateTable
CREATE TABLE "crm_permissions" (
    "crm_permission_id" SERIAL NOT NULL,
    "crm_permission_name" TEXT NOT NULL,
    "crm_permission_display_name" TEXT NOT NULL,
    "crm_permission_description" TEXT NOT NULL,
    "status" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "crm_permissions_pkey" PRIMARY KEY ("crm_permission_id")
);

-- CreateTable
CREATE TABLE "crm_permission_components" (
    "crm_permission_component_id" SERIAL NOT NULL,
    "crm_permission_component_name" TEXT NOT NULL,
    "crm_permission_component_display_name" TEXT NOT NULL,
    "crm_permission_component_description" TEXT NOT NULL,
    "status" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "crm_permission_id" INTEGER NOT NULL,

    CONSTRAINT "crm_permission_components_pkey" PRIMARY KEY ("crm_permission_component_id")
);

-- CreateTable
CREATE TABLE "crm_permission_groups" (
    "crm_permission_group_id" SERIAL NOT NULL,
    "activate" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "crm_role_id" TEXT NOT NULL,
    "crm_permission_id" INTEGER NOT NULL,
    "crm_permission_component_id" INTEGER NOT NULL,

    CONSTRAINT "crm_permission_groups_pkey" PRIMARY KEY ("crm_permission_group_id")
);

-- CreateTable
CREATE TABLE "crm_customers" (
    "crm_customer_id" TEXT NOT NULL,
    "crm_customer_phone" TEXT NOT NULL,
    "crm_customer_email" TEXT,
    "crm_customer_fullname" TEXT NOT NULL,
    "crm_customer_gender" TEXT NOT NULL,
    "crm_customer_type" TEXT NOT NULL,
    "crm_customer_birth_of_date" TIMESTAMP(3),
    "crm_customer_total_price" DOUBLE PRECISION NOT NULL DEFAULT 0.00,
    "crm_customer_condition_service" BOOLEAN NOT NULL DEFAULT true,
    "crm_customer_condition_privacy" BOOLEAN NOT NULL DEFAULT true,
    "crm_customer_sms_service" BOOLEAN NOT NULL DEFAULT false,
    "crm_customer_email_service" BOOLEAN NOT NULL DEFAULT false,
    "crm_customer_line_token" TEXT,
    "status" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "activeAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted" BOOLEAN NOT NULL DEFAULT false,
    "crm_customer_level_id" TEXT,
    "crm_user_code" TEXT,

    CONSTRAINT "crm_customers_pkey" PRIMARY KEY ("crm_customer_id")
);

-- CreateTable
CREATE TABLE "crm_customer_levels" (
    "crm_customer_level_id" TEXT NOT NULL,
    "crm_customer_level_name" TEXT NOT NULL,
    "crm_customer_level_amount" INTEGER NOT NULL,
    "img_url" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "crm_customer_levels_pkey" PRIMARY KEY ("crm_customer_level_id")
);

-- CreateTable
CREATE TABLE "crm_customer_address" (
    "crm_customer_address_id" SERIAL NOT NULL,
    "crm_customer_address_type" TEXT NOT NULL,
    "crm_customer_address_detail" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,
    "crm_customer_id" TEXT NOT NULL,

    CONSTRAINT "crm_customer_address_pkey" PRIMARY KEY ("crm_customer_address_id")
);

-- CreateTable
CREATE TABLE "crm_customer_contacts" (
    "crm_customer_contact_id" SERIAL NOT NULL,
    "crm_customer_contact_type" TEXT NOT NULL,
    "crm_customer_contact_name" TEXT NOT NULL,
    "crm_customer_contact_email" TEXT NOT NULL,
    "crm_customer_contact_phone" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,
    "crm_customer_id" TEXT NOT NULL,

    CONSTRAINT "crm_customer_contacts_pkey" PRIMARY KEY ("crm_customer_contact_id")
);

-- CreateTable
CREATE TABLE "crm_points" (
    "crm_point_id" SERIAL NOT NULL,
    "crm_point_name" TEXT NOT NULL,
    "crm_point_type_promotion" BOOLEAN NOT NULL,
    "crm_point_description" TEXT NOT NULL,
    "crm_point_ratio_status" BOOLEAN NOT NULL,
    "crm_point_ratio_point" INTEGER,
    "crm_point_welcome_status" BOOLEAN NOT NULL,
    "crm_point_welcome_point" INTEGER,
    "crm_point_percent_status" BOOLEAN NOT NULL,
    "crm_point_percent_point" INTEGER,
    "crm_point_percent_special_calcurate" BOOLEAN NOT NULL DEFAULT false,
    "crm_point_multiple_status" BOOLEAN NOT NULL,
    "crm_point_multiple_point" DOUBLE PRECISION,
    "crm_point_multiple_special_calcurate" BOOLEAN NOT NULL DEFAULT false,
    "crm_point_start_date" TIMESTAMP(3) NOT NULL,
    "crm_point_end_date" TIMESTAMP(3) NOT NULL,
    "status" BOOLEAN NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "crm_points_pkey" PRIMARY KEY ("crm_point_id")
);

-- CreateTable
CREATE TABLE "crm_point_transactions" (
    "crm_point_transaction_id" TEXT NOT NULL,
    "crm_point_transaction_total_point" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "crm_point_id" INTEGER,
    "crm_point_special_quota_id" TEXT,

    CONSTRAINT "crm_point_transactions_pkey" PRIMARY KEY ("crm_point_transaction_id")
);

-- CreateTable
CREATE TABLE "crm_point_branchs" (
    "crm_point_branch_id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "crm_point_id" INTEGER NOT NULL,
    "crm_branch_id" INTEGER NOT NULL,

    CONSTRAINT "crm_point_branchs_pkey" PRIMARY KEY ("crm_point_branch_id")
);

-- CreateTable
CREATE TABLE "crm_branchs" (
    "crm_branch_id" SERIAL NOT NULL,
    "crm_branch_name" TEXT NOT NULL,
    "crm_branch_address" TEXT NOT NULL,
    "crm_branch_company" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "crm_branchs_pkey" PRIMARY KEY ("crm_branch_id")
);

-- CreateTable
CREATE TABLE "crm_reward" (
    "crm_reward_id" TEXT NOT NULL,
    "crm_reward_name" TEXT NOT NULL,
    "crm_reward_detail" TEXT NOT NULL,
    "crm_reward_term" TEXT NOT NULL,
    "crm_reward_image_url" TEXT NOT NULL,
    "crm_reward_point" INTEGER NOT NULL,
    "crm_reward_quota_status" BOOLEAN NOT NULL,
    "crm_reward_quota_total" INTEGER,
    "crm_reward_start_date" TIMESTAMP(3) NOT NULL,
    "crm_reward_end_date" TIMESTAMP(3) NOT NULL,
    "crm_reward_branchs" TEXT[],
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "crm_reward_pkey" PRIMARY KEY ("crm_reward_id")
);

-- CreateTable
CREATE TABLE "crm_reward_member" (
    "crm_reward_member_id" TEXT NOT NULL,
    "crm_reward_member_name" TEXT NOT NULL,
    "crm_reward_member_detail" TEXT NOT NULL,
    "crm_reward_member_image_url" TEXT NOT NULL,
    "crm_reward_member_percent_status" BOOLEAN NOT NULL,
    "crm_reward_member_percent_total" INTEGER,
    "crm_reward_member_start_date" TIMESTAMP(3) NOT NULL,
    "crm_reward_member_end_date" TIMESTAMP(3) NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,
    "crm_customer_level_id" TEXT NOT NULL,

    CONSTRAINT "crm_reward_member_pkey" PRIMARY KEY ("crm_reward_member_id")
);

-- CreateTable
CREATE TABLE "crm_quota" (
    "crm_quota_id" TEXT NOT NULL,
    "crm_quota_status" BOOLEAN NOT NULL DEFAULT false,
    "crm_quota_code" TEXT NOT NULL,
    "crm_quota_redeem_date" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "crm_customer_id" TEXT,
    "crm_reward_id" TEXT NOT NULL,

    CONSTRAINT "crm_quota_pkey" PRIMARY KEY ("crm_quota_id")
);

-- CreateTable
CREATE TABLE "crm_customer_points" (
    "crm_customer_point_id" TEXT NOT NULL,
    "crm_customer_point_type" TEXT NOT NULL,
    "crm_customer_point_sum" INTEGER NOT NULL,
    "crm_customer_point_description" TEXT NOT NULL,
    "crm_customer_point_exp_status" BOOLEAN NOT NULL,
    "crm_customer_point_exp_date" INTEGER,
    "crm_customer_point_branch_use" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "crm_customer_id" TEXT NOT NULL,
    "crm_point_adjustment_id" TEXT,

    CONSTRAINT "crm_customer_points_pkey" PRIMARY KEY ("crm_customer_point_id")
);

-- CreateTable
CREATE TABLE "crm_point_income" (
    "crm_point_income_id" SERIAL NOT NULL,
    "crm_point_income_description" TEXT NOT NULL,
    "crm_point_income_total" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "crm_customer_point_id" TEXT NOT NULL,

    CONSTRAINT "crm_point_income_pkey" PRIMARY KEY ("crm_point_income_id")
);

-- CreateTable
CREATE TABLE "crm_point_used" (
    "crm_point_used_id" SERIAL NOT NULL,
    "crm_point_used_description" TEXT NOT NULL,
    "crm_point_used_total" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "crm_customer_point_id" TEXT NOT NULL,

    CONSTRAINT "crm_point_used_pkey" PRIMARY KEY ("crm_point_used_id")
);

-- CreateTable
CREATE TABLE "crm_point_adjustments" (
    "crm_point_adjustment_id" TEXT NOT NULL,
    "crm_point_adjustment_status" TEXT NOT NULL,
    "crm_point_adjustment_file_name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "crm_user_code" TEXT NOT NULL,

    CONSTRAINT "crm_point_adjustments_pkey" PRIMARY KEY ("crm_point_adjustment_id")
);

-- CreateTable
CREATE TABLE "crm_point_specials" (
    "crm_point_special_id" TEXT NOT NULL,
    "crm_point_special_name" TEXT NOT NULL,
    "crm_point_special_description" TEXT NOT NULL,
    "crm_point_special_percent_status" BOOLEAN NOT NULL,
    "crm_point_special_percent_point" INTEGER,
    "crm_point_special_percent_fix_cost_status" BOOLEAN NOT NULL,
    "crm_point_special_percent_fix_cost_min" INTEGER,
    "crm_point_special_percent_fix_cost_max" INTEGER,
    "crm_point_special_multiple_status" BOOLEAN NOT NULL,
    "crm_point_special_multiple_point" INTEGER,
    "crm_point_special_multiple_fix_cost_status" BOOLEAN NOT NULL,
    "crm_point_special_multiple_fix_cost_min" INTEGER,
    "crm_point_special_multiple_fix_cost_max" INTEGER,
    "crm_point_special_start_date" TIMESTAMP(3) NOT NULL,
    "crm_point_special_end_date" TIMESTAMP(3) NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "crm_point_specials_pkey" PRIMARY KEY ("crm_point_special_id")
);

-- CreateTable
CREATE TABLE "crm_point_members" (
    "crm_point_member_id" TEXT NOT NULL,
    "crm_point_member_name" TEXT NOT NULL,
    "crm_point_member_description" TEXT NOT NULL,
    "crm_point_member_percent_status" BOOLEAN NOT NULL,
    "crm_point_member_percent_point" INTEGER,
    "crm_point_member_multiple_status" BOOLEAN NOT NULL,
    "crm_point_member_multiple_point" INTEGER,
    "crm_point_member_start_date" TIMESTAMP(3) NOT NULL,
    "crm_point_member_end_date" TIMESTAMP(3) NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "crm_customer_level_id" TEXT NOT NULL,

    CONSTRAINT "crm_point_members_pkey" PRIMARY KEY ("crm_point_member_id")
);

-- CreateTable
CREATE TABLE "crm_point_special_quota" (
    "crm_point_special_quota_id" TEXT NOT NULL,
    "crm_point_special_quota_status" BOOLEAN NOT NULL DEFAULT false,
    "crm_point_special_quota_code" TEXT NOT NULL,
    "crm_point_special_quota_redeem_date" TIMESTAMP(3),
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "crm_point_special_id" TEXT,
    "crm_customer_id" TEXT,

    CONSTRAINT "crm_point_special_quota_pkey" PRIMARY KEY ("crm_point_special_quota_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "crm_users_crm_user_code_key" ON "crm_users"("crm_user_code");

-- CreateIndex
CREATE UNIQUE INDEX "crm_users_crm_user_email_key" ON "crm_users"("crm_user_email");

-- CreateIndex
CREATE UNIQUE INDEX "crm_customers_crm_customer_id_key" ON "crm_customers"("crm_customer_id");

-- CreateIndex
CREATE UNIQUE INDEX "crm_customers_crm_customer_phone_key" ON "crm_customers"("crm_customer_phone");

-- CreateIndex
CREATE UNIQUE INDEX "crm_customers_crm_customer_email_key" ON "crm_customers"("crm_customer_email");

-- AddForeignKey
ALTER TABLE "crm_users" ADD CONSTRAINT "crm_users_crm_role_id_fkey" FOREIGN KEY ("crm_role_id") REFERENCES "crm_roles"("crm_role_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_users" ADD CONSTRAINT "crm_users_crm_branch_id_fkey" FOREIGN KEY ("crm_branch_id") REFERENCES "crm_branchs"("crm_branch_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_user_logger" ADD CONSTRAINT "crm_user_logger_crm_user_id_fkey" FOREIGN KEY ("crm_user_id") REFERENCES "crm_users"("crm_user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_permission_components" ADD CONSTRAINT "crm_permission_components_crm_permission_id_fkey" FOREIGN KEY ("crm_permission_id") REFERENCES "crm_permissions"("crm_permission_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_permission_groups" ADD CONSTRAINT "crm_permission_groups_crm_role_id_fkey" FOREIGN KEY ("crm_role_id") REFERENCES "crm_roles"("crm_role_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_permission_groups" ADD CONSTRAINT "crm_permission_groups_crm_permission_id_fkey" FOREIGN KEY ("crm_permission_id") REFERENCES "crm_permissions"("crm_permission_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_permission_groups" ADD CONSTRAINT "crm_permission_groups_crm_permission_component_id_fkey" FOREIGN KEY ("crm_permission_component_id") REFERENCES "crm_permission_components"("crm_permission_component_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_customers" ADD CONSTRAINT "crm_customers_crm_customer_level_id_fkey" FOREIGN KEY ("crm_customer_level_id") REFERENCES "crm_customer_levels"("crm_customer_level_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_customers" ADD CONSTRAINT "crm_customers_crm_user_code_fkey" FOREIGN KEY ("crm_user_code") REFERENCES "crm_users"("crm_user_code") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_customer_address" ADD CONSTRAINT "crm_customer_address_crm_customer_id_fkey" FOREIGN KEY ("crm_customer_id") REFERENCES "crm_customers"("crm_customer_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_customer_contacts" ADD CONSTRAINT "crm_customer_contacts_crm_customer_id_fkey" FOREIGN KEY ("crm_customer_id") REFERENCES "crm_customers"("crm_customer_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_point_transactions" ADD CONSTRAINT "crm_point_transactions_crm_point_id_fkey" FOREIGN KEY ("crm_point_id") REFERENCES "crm_points"("crm_point_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_point_transactions" ADD CONSTRAINT "crm_point_transactions_crm_point_special_quota_id_fkey" FOREIGN KEY ("crm_point_special_quota_id") REFERENCES "crm_point_special_quota"("crm_point_special_quota_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_point_branchs" ADD CONSTRAINT "crm_point_branchs_crm_point_id_fkey" FOREIGN KEY ("crm_point_id") REFERENCES "crm_points"("crm_point_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_point_branchs" ADD CONSTRAINT "crm_point_branchs_crm_branch_id_fkey" FOREIGN KEY ("crm_branch_id") REFERENCES "crm_branchs"("crm_branch_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_reward_member" ADD CONSTRAINT "crm_reward_member_crm_customer_level_id_fkey" FOREIGN KEY ("crm_customer_level_id") REFERENCES "crm_customer_levels"("crm_customer_level_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_quota" ADD CONSTRAINT "crm_quota_crm_customer_id_fkey" FOREIGN KEY ("crm_customer_id") REFERENCES "crm_customers"("crm_customer_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_quota" ADD CONSTRAINT "crm_quota_crm_reward_id_fkey" FOREIGN KEY ("crm_reward_id") REFERENCES "crm_reward"("crm_reward_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_customer_points" ADD CONSTRAINT "crm_customer_points_crm_customer_id_fkey" FOREIGN KEY ("crm_customer_id") REFERENCES "crm_customers"("crm_customer_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_customer_points" ADD CONSTRAINT "crm_customer_points_crm_customer_point_branch_use_fkey" FOREIGN KEY ("crm_customer_point_branch_use") REFERENCES "crm_branchs"("crm_branch_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_customer_points" ADD CONSTRAINT "crm_customer_points_crm_point_adjustment_id_fkey" FOREIGN KEY ("crm_point_adjustment_id") REFERENCES "crm_point_adjustments"("crm_point_adjustment_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_point_income" ADD CONSTRAINT "crm_point_income_crm_customer_point_id_fkey" FOREIGN KEY ("crm_customer_point_id") REFERENCES "crm_customer_points"("crm_customer_point_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_point_used" ADD CONSTRAINT "crm_point_used_crm_customer_point_id_fkey" FOREIGN KEY ("crm_customer_point_id") REFERENCES "crm_customer_points"("crm_customer_point_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_point_adjustments" ADD CONSTRAINT "crm_point_adjustments_crm_user_code_fkey" FOREIGN KEY ("crm_user_code") REFERENCES "crm_users"("crm_user_code") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_point_members" ADD CONSTRAINT "crm_point_members_crm_customer_level_id_fkey" FOREIGN KEY ("crm_customer_level_id") REFERENCES "crm_customer_levels"("crm_customer_level_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_point_special_quota" ADD CONSTRAINT "crm_point_special_quota_crm_point_special_id_fkey" FOREIGN KEY ("crm_point_special_id") REFERENCES "crm_point_specials"("crm_point_special_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crm_point_special_quota" ADD CONSTRAINT "crm_point_special_quota_crm_customer_id_fkey" FOREIGN KEY ("crm_customer_id") REFERENCES "crm_customers"("crm_customer_id") ON DELETE SET NULL ON UPDATE CASCADE;
