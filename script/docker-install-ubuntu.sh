#!/bin/bash -x

CODENAME=$(cat /etc/os-release | grep UBUNTU_CODENAME | cut -d'=' -f2)
ARCH=$(dpkg --print-architecture)
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=${ARCH}] https://download.docker.com/linux/ubuntu $CODENAME stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce docker-compose -y
sudo usermod -aG docker ${USER}
sudo su - ${USER}

