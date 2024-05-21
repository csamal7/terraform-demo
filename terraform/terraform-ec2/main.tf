provider "aws" {
  region = "us-east-1"
}

resource "aws_default_vpc" "default" {
}

resource "aws_security_group" "http_server_sg" {
  name   = "http_server_sg"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

resource "aws_instance" "my_ec2_http_server" {
  ami = "ami-04b70fa74e45c3917"
  #ami                    = data.aws_ami.aws_ubuntu_latest.id
  key_name               = "test-aws-login"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  subnet_id              = tolist(data.aws_subnets.default_subnets.ids)[0]
  #subnet_id              = "subnet-03e9429cbb8784a4a"

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y apache2",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2",
      "echo Welcome to EC2 virtual server ${self.public_dns} created by Terraform | sudo tee /var/www/html/index.html"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.aws_key_pair)
    }
  }
}
