provider "aws" {
  region = "us-west-2"
  assume_role {
    role_arn = "arn:aws:iam::123456789012:role/my-assumed-role"
  }
}

# Upload multiple files to an existing S3 bucket
locals {
  file_paths = [
    "/path/to/local/file1",
    "/path/to/local/file2",
    "/path/to/local/file3"
  ]
}

resource "aws_s3_bucket_object" "my_objects" {
  for_each = { for idx, path in local.file_paths : idx => path }

  bucket = "my-existing-bucket-name" # or "arn:aws:s3:::my-existing-bucket-name"
  key    = each.value
  source = each.value
}

# Create an EC2 instance role and attach a custom policy
resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "ec2_role_policy" {
  name   = "ec2_role_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.my_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_role_policy" {
  policy_arn = aws_iam_policy.ec2_role_policy.arn
  role       = aws_iam_role.ec2_role.name
}
