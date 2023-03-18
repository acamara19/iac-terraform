provider "aws" {
  region = "us-west-2"
}

# Create a VPC endpoint
resource "aws_vpc_endpoint" "my_endpoint" {
  vpc_id              = "vpc-1234567890abcdef0"
  service_name        = "com.amazonaws.us-west-2.s3"
  private_dns_enabled = true
}

# Create a new security group for the endpoint
resource "aws_security_group" "my_sg" {
  name_prefix = "my_sg_"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"] # Replace with your own CIDR block
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"] # Replace with your own CIDR block
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"] # Replace with your own CIDR block
  }
}

# Attach the security group to the endpoint
resource "aws_vpc_endpoint_security_group_attachment" "my_sg_attachment" {
  security_group_id = aws_security_group.my_sg.id
  vpc_endpoint_id   = aws_vpc_endpoint.my_endpoint.id
}

# Attach all available subnets to the endpoint
data "aws_subnet_ids" "all" {
  vpc_id = "vpc-1234567890abcdef0" # Replace with your own VPC ID
}

resource "aws_vpc_endpoint_subnet_association" "all_subnets" {
  for_each = toset(data.aws_subnet_ids.all.ids)

  subnet_id       = each.value
  vpc_endpoint_id = aws_vpc_endpoint.my_endpoint.id
}
