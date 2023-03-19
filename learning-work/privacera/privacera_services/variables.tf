variable "AWS_PROFILE" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "custom_tcp_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    description = string
  }))
}