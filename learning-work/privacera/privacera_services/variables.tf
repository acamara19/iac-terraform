variable "aws_profile" {
  type        = string
  description = "AWS profile to use for authentication"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket to use"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to use for the VPC endpoints"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block for the security group rules"
}

variable "files_to_upload" {
  type        = map(list(string))
  description = "Map of directories and files to upload to the S3 bucket"
}

variable "external_account_id" {
    type        = string
    description = "External AWS account ID for cross-account access"
}

variable "external_role_name" {
  type        = string
  description = "External IAM role name for cross-account access"
}
