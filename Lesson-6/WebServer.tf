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

#Sozdanie Elastic IP (eip) i priattachivanie ego k zsm_webserver
resource "aws_eip" "my_static_ip_for_zsm" {
  instance = aws_instance.zsm_webserver.id
}

resource "aws_instance" "zsm_webserver" {
  ami                    = "ami-0c115dbd34c69a004" #Amazon Linux 2 AMI (HVM)
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.zsm_webserver.id]
  #Probely vse steret'
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Serg"
    l_name = "Z"
    names  = ["Vasys", "Petya", "Olya", "Vnuchka", "Myshka", "Test", "XYZ"]
  })

  tags = {
    Name = "Webserver ZSM"
  }
  /* #Chtoby nel'za bylo zamochit' instance
  lifecycle {
    prevent_destroy = true
  }
*/
  /*  #Ignoriruet polya "ami" i "user_data". Ne peresozdaet instane, esli eti polya izmenilis'
  lifecycle {
    ignore_changes = ["ami", "user_data"]
  }
*/

  #Snachala sozdaet noviy instance, potom ubivaet stariy
  lifecycle {
    create_before_destroy = true
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
