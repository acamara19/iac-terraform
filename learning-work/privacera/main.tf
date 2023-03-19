provider "aws" {
  region = "us-west-2"
  profile = var.AWS_PROFILE
}

terraform {
  backend "s3" {
    bucket = "your-s3-bucket-name"
    key    = "terraform-backend/terraform.tfstate"
    region = "us-west-2"
  }
}

# Rest of the file remains the same

module "privacera_services" {
  source = "./privacera_services"

  aws_profile = var.AWS_PROFILE
  vpc_cidr = var.vpc_cidr
  vpc_id = var.vpc_id
  custom_tcp_rules = var.custom_tcp_rules
}

module "privacera_services" {
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
  value = module.privacera_services.dxdl_svc_privacera_role_arn
}

output "privacera_privatelink_security_group_id" {
  value = module.privacera_services.privacera_privatelink_security_group_id
}

output "vpc_endpoints" {
  value
