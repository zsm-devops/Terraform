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

resource "aws_instance" "zsm_webserver" {
  ami                    = "ami-0c115dbd34c69a004" #Amazon Linux 2 AMI (HVM)
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.zsm_webserver.id]
  #Probely vse steret'
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Serg"
    l_name = "Z"
    names  = ["Vasys", "Petya", "Olya", "Vnuchka", "Myshka"]
  })

  tags = {
    Name = "Webserver ZSM"
  }

}

resource "aws_security_group" "zsm_webserver" {
  name        = "Webserver Security Group"
  description = "My first Security Group"

  #Incomming Traffic
  ingress {
    from_port   = 80 # Open Port 80 fo WebServer
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Where is open Port 80 - anywhere
  }
  ingress {
    from_port   = 443 # Open Port 80 fo WebServer
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Where is open Port 80 - anywhere
  }

  #Outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Webserver Security Group"
  }
}
