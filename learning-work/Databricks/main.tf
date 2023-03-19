module "vpc" {
  source = "./vpc_module"
  # Add any required variables for the VPC module here
}

module "vpc_s3_gateway_endpoint" {
  source = "./vpc_s3_gateway_endpoint"

  aws_region      = "us-west-2"
  vpc_id          = module.vpc.vpc_id
  route_table_ids = module.vpc.route_table_ids
}
