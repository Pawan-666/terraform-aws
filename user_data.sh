#!/bin/bash
sudo yum update -y
sudo yum install httpd git -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo git clone https://github.com/gabrielecirulli/2048.git
sudo cp -R 2048/* /var/www/html/
sudo systemctl restart httpd
