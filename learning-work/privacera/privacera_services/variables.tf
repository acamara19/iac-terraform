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

variable "aws_profile" {
  type        = string
  description = "AWS profile to be used for authentication"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket to be used for file upload and backend storage"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC for which the endpoints and security group will be created"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR of the VPC for which the security group will be created"
}

variable "files_to_upload" {
  type        = map(list(string))
  description = "A map of subfolder names and the list of file names to be uploaded to the S3 bucket"
}

variable "external_account_id" {
  type        = string
  description = "The AWS account ID of the external account for the custom assume role policy"
}

variable "external_role_name" {
  type        = string
  description = "The name of the IAM role from the different account for the custom assume role policy"
}
