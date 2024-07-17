variable "region" {
  default = "us-east-1"
}

provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_instance" "server" {
  ami           = "ami-04c58523038d79132" # Ubunutu Bionic
  instance_type = "t2.micro"
  key_name      = "automation"
  root_block_device {
    volume_size           = "10"
    volume_type           = "standard"
    delete_on_termination = "false"
  }
  tags = {
    Name = "kube"
  }
}

#resource "aws_key_pair" "admin-server" {
#  key_name   = "admin"
#  public_key = file(var.key_pair_path["public_key_path"])
#}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
