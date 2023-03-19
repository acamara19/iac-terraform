resource "aws_security_group" "privacera_privatelink" {
  name = "privacera-privatelink"

  dynamic "ingress" {
    for_each = var.custom_tcp_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]
      description = ingress.value.description
    }
  }
}

# Rest of the file remains the same
resource "aws_security_group" "privacera_privatelink" {
  name = "privacera-privatelink"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
}

module "privatelink_endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/privatelink-endpoints"

  name = "privacera"
  vpc_id = var.vpc_id
  service_name_prefix = "com.amazonaws.${data.aws_region.current.name}"

  endpoints = {
    ec2      = { security_group_ids = [aws_security_group.privacera_privatelink.id] }
    rds      = { security_group_ids = [aws_security_group.privacera_privatelink.id] }
    s3       = { security_group_ids = [aws_security_group.privacera_privatelink.id] }
  }
}
