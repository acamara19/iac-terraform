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
