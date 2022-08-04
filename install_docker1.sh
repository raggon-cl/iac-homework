#!/bin/bash

sudo yum -y update
sudo yum -y install docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -G docker ec2-user

sudo wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)
sudo mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
sudo chmod -v +x /usr/local/bin/docker-compose

#Contenedores a Ejecutar en cada VM
#errm/cheese:wensleydale
#errm/cheese:cheddar
#errm/cheese:stilton

sudo docker run -d -p 80:80 errm/cheese:wensleydale
#sudo docker run -d -p 80:80 errm/cheese:cheddar
#sudo docker run -d -p 80:80 errm/cheese:stilton
