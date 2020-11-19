#!/bin/bash
sudo yum update -y
#yum -y install httpd
sudo yum install git -y
sudo git config --global user.name "aws_user_from_terraform"
ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
