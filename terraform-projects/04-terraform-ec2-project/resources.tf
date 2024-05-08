

#using aws  default vpc
resource "aws_default_vpc" "default" {

}

#creating a Security Group with these rules
# So we'll allow access to port 80(http) and We'll allow access to port 22(ssh) from everywhere.
#CIDR ["0.0.0.0/0"] --> from which ip addresses we want to allow traffic in our ec2 instance

resource "aws_security_group" "http_server_sg" {
  name = "http_server_sg"
  # vpc_id = "vpc-05b681c0c2ac6989c" -->hardcoding 
  vpc_id = aws_default_vpc.default.id

  # ingress ---> where do u want to allow traffic from
  # "Allow traffic on port 80 TCP from anywhere."
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # We are allowing traffic on port 22 for SSH.
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # egress ---> What kind of things can you do from this HTTP server?
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "http_server_sg"
  }
}
# tags will help us to identify a resource and tie it to a specific environment.When we create a
# lot of resources in the cloud, it might be difficult to manage all of them and that's where 
# tags really, really help.


# So once you create a security group by default in AWS, you'd be able to send requests from that HTTP server 
# to any system on the internet, to any IP address.But by default, what Terraform does is it does
# not allow any egress, so it disables the egress.So we would need to actually allow it explicitly.

#creating ec2 instance
resource "aws_instance" "http_server" {
  # ami                    = "ami-013e83f579886baeb"
  ami                    = data.aws_ami.latest_ami.id
  key_name               = "default-ec2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  # subnet_id              = "subnet-014214d38e9b02863"
  subnet_id = data.aws_subnets.default_subnets.ids[1]

  #SSH into the newly created ec2 instance
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)
  }

  # Specifies the provisioner type as remote-exec, which allows executing commands on the remote
  # instance over SSH.
  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y", #  Installs the Apache HTTP Server (httpd) package using YUM package manager with automatic confirmation.
      "sudo service httpd start",  # Starts the Apache HTTP Server service.
      "echo Welcome to in28minutes - Virtual Server is at ${self.public_dns} | sudo tee /var/www/html/index.html"
      # Creates an index.html file with a welcome message containing the public DNS of the EC2 instance in the default web server directory.
    ]
  }
}




