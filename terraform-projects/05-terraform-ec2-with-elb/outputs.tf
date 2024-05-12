output "all_http_server_public_dns" {
  value = values(aws_instance.http_servers).*.public_dns
}


output "all_default_subnets" {
  value = data.aws_subnets.default_subnets.ids
}

output "elb_public_dns" {
  value = aws_elb.elb.dns_name
}