output "vpc_endpoint_id" {
  value = aws_vpc_endpoint.s3_gateway_endpoint.id
  description = "The ID of the created VPC endpoint."
}
