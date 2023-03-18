provider "aws" {
  region = "us-west-2"
}

module "s3_bucket_files" {
  source = "./modules/s3_bucket_files"
  bucket_name = "my-existing-bucket-name" # Replace with your own S3 bucket name
  file_paths = [
    "/path/to/local/file1",
    "/path/to/local/file2",
    "/path/to/local/file3"
  ]
}

module "vpc_endpoint" {
  source = "./modules/vpc_endpoint"
  vpc_id = "vpc-1234567890abcdef0" # Replace with your own VPC ID
}
