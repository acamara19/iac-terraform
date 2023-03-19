terraform {
  backend "s3" {
    bucket         = var.s3_bucket_name
    key            = "terraform-backend/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "my-lock-table"
  }
}

provider "aws" {
  region  = "us-west-2"
  profile = var.aws_profile
}

locals {
  files_to_upload = {
    "privacera/prod_us_6_5" = fileset("${path.module}/privacera_init_scripts/prod_us_6_5", "*")
  }
}

module "privacera_module" {
  source = "./privacera_module"

  aws_profile         = var.aws_profile
  s3_bucket_name      = var.s3_bucket_name
  vpc_id              = var.vpc_id
  vpc_cidr            = var.vpc_cidr
  files_to_upload     = local.files_to_upload
  external_account_id = var.external_account_id
  external_role_name  = var.external_role_name
}

output "dxdl_svc_privacera_role_arn" {
  value = module.privacera_module.dxdl_svc_privacera_role_arn
}

output "privacera_privatelink_security_group_id" {
  value = module.privacera_module.privacera_privatelink_security_group_id
}

output "vpc_endpoints" {
  value = module.privacera_module.vpc_endpoints
}
