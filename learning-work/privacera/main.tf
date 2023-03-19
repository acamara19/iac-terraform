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
