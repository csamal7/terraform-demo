output "aws_security_group_http_server_details" {
  value = aws_security_group.elb_http_server_sg
}

output "my_ec2_http_dns_details" {
  value = values(aws_instance.http_servers).*.id
}

output "elb_public_dns" {
  value = aws_elb.elb
}
