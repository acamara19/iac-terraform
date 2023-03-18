terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket" # Replace with your own S3 bucket name
    key    = "terraform.tfstate"
    region = "us-west-2" # Replace with your own AWS region
  }
}
