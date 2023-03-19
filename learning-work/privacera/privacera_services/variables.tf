variable "AWS_PROFILE" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "custom_tcp_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    description = string
  }))
}

variable "private_subnet_ids" {
  type = list(string)
  description = "List of private subnet IDs to associate with the VPC Endpoints"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket where the files will be uploaded"
}
