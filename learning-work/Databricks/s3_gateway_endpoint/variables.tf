variable "aws_region" {
  type        = string
  description = "AWS region where the VPC and gateway endpoint will be created."
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where the S3 gateway endpoint will be created."
}

variable "route_table_ids" {
  type        = list(string)
  description = "List of route table IDs to associate with the S3 gateway endpoint."
}
