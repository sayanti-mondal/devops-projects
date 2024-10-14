output "http_server_public_dns" {
  value = aws_instance.http_server.public_dns
}

output "default_vpc_id" {
  value = aws_default_vpc.default.id
}

output "all_default_subnets" {
  value = data.aws_subnets.default_subnets.ids
}

output "my_ami_id" {
  value = data.aws_ami.latest_ami.id
}