terraform {
  backend "s3" {
    bucket         = "my-s3-bucket"
    key            = "terraform-backend/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "my-lock-table"
  }
}

provider "aws" {
  region  = "us-west-2"
  profile = "saml"
}

locals {
  files_to_upload = {
    "privacera/prod_us_6_5" = [
      "${path.module}/privacera_init_scripts/prod_us_6_5/file1.txt",
      "${path.module}/privacera_init_scripts/prod_us_6_5/file2.txt",
      "${path.module}/privacera_init_scripts/prod_us_6_5/file3.txt",
      "${path.module}/privacera_init_scripts/prod_us_6_5/file4.txt"
    ]
  }
}

module "privacera_module" {
  source = "./privacera_module"

  aws_profile         = "saml"
  s3_bucket_name      = "my-s3-bucket"
  vpc_id              = "vpc-123456"
  vpc_cidr            = "10.0.0.0/16"
  files_to_upload     = local.files_to_upload
  external_account_id = "123456789012"
  external_role_name  = "ExternalRole"
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
