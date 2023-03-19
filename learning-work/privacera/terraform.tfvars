aws_profile         = "saml"
s3_bucket_name      = "my-s3-bucket"
vpc_id              = "vpc-123456"
vpc_cidr            = "10.0.0.0/16"
external_account_id = "123456789012"
external_role_name  = "ExternalRole"

custom_tcp_rules = [
  {
    from_port   = 80
    to_port     = 80
    description = "HTTP"
  },
  {
    from_port   = 443
    to_port     = 443
    description = "HTTPS"
  },
  {
    from_port   = 22
    to_port     = 22
    description = "SSH"
  }
]
