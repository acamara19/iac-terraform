resource "aws_iam_role" "dxdl_svc_privacera" {
  name = "dxdl-svc-privacera"
  path = "/OneCloud/"

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

output "role_id" {
  value = aws_iam_role.dxdl_svc_privacera.id
}
