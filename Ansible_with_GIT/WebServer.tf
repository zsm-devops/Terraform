#-----------------------------------------------
# My terraform
#
# Build Ansible Server with GIT
#
# Made by ZSM
#-----------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "Ansible_server_with_GIT" {
  ami                    = "ami-07dfba995513840b5" #Amazon Linux 2 AMI (HVM)
  instance_type          = "t2.micro"
  key_name               = "frankfurt_key_pair" #Existing in AWS Key Pair name
  vpc_security_group_ids = [aws_security_group.Ansible_server_with_GIT.id]
  #Probely vse steret'
  user_data = file("user_data.sh")

  tags = {
    Name = "Ansible Server with GIT"
  }

}

resource "aws_security_group" "Ansible_server_with_GIT" {
  name        = "Webserver Security Group"
  description = "My first Security Group"

  #Incomming Traffic
  ingress {
    from_port   = 22 # Open Port 22 for SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Where is open Port 22 - anywhere
  }
  ingress {
    from_port   = 80 # Open Port 80 for WebServer
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Where is open Port 80 - anywhere
  }
  ingress {
    from_port   = 443 # Open Port 443 for WebServer
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Where is open Port 443 - anywhere
  }

  #Outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Group"
  }
}
