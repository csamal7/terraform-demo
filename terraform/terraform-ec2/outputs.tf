output "aws_security_group_http_server_details" {
  value = aws_security_group.http_server_sg
}

output "my_ec2_http_dns_details" {
  value = aws_instance.my_ec2_http_server.public_dns
}
