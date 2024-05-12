
# using data provider to find the all the subnets in default vpc
data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_default_vpc.default.id]
  }
}
# in the above code, we want to use a filter on name which should be vpc-id

# getting all the ami ids availaible
# data "aws_ami_ids" "all_ami_ids"{
#    owners = ["amazon"]
# }

data "aws_ami" "latest_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]

  }
}