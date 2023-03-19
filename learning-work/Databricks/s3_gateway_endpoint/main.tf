variable "aws_region" {
  type        = string
  description = "AWS region where the VPC and gateway endpoint will be created."
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where the S3 gateway endpoint will be created."
}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc_endpoint" "s3_gateway_endpoint" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.s3"

  route_table_ids = var.route_table_ids

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:*"
        Effect   = "Allow"
        Resource = "*"
        Principal = "*"
      }
    ]
  })

  tags = {
    Name = "s3-gateway-endpoint"
  }
}

output "vpc_endpoint_id" {
  value = aws_vpc_endpoint.s3_gateway_endpoint.id
}
