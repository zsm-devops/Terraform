#-----------------------------------------------
# My terraform
#
# Build WebServer during Bootstrap
#
# Made by ZSM
#-----------------------------------------------

provider "aws" {
  region = "eu-central-1"
}


resource "aws_security_group" "zsm_webserver" {
  name        = "Webserver Security Group"
  description = "My first Security Group"

  #Incomming Traffic
  dynamic "ingress" {
    for_each = ["80", "443", "8080", "1541", "9092"]
    content {
      from_port   = ingress.value # Open Port 80 fo WebServer
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] #Where is open Port 80 - anywhere

    }
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
  }

  #Outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Dynamic Security Group"
  }
}
