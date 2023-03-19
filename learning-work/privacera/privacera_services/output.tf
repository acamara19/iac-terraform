output "dxdl_svc_privacera_role_arn" {
  value       = aws_iam_role.dxdl_svc_privacera.arn
  description = "The ARN of the created dxdl-svc-privacera IAM role"
}

output "privacera_privatelink_security_group_id" {
  value       = aws_security_group.privacera_privatelink.id
  description = "The ID of the created privacera-privatelink security group"
}

output "vpc_endpoints" {
  value = {
    for endpoint in aws_vpc_endpoint.privatelink : endpoint.service_name => endpoint.id
  }
  description = "A map of the VPC endpoint service names and their IDs"
}
