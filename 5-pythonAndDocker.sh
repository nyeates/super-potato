#!/bin/bash
echo -e "\n*****\nPYTHON AND DOCKER INSTALL\n*****\n"
if ((${EUID:-0} || "$(id -u)")); then echo "Running as user: $EUID $id"; else echo "ERROR: Needs to be run as NON ROOT."; exit 100; fi

echo -e "\n***** Install Python3\n"
sudo apt install python3
sudo apt install python3-pip

echo -e "\n***** Install pre-req packages\n"
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo -e "\n***** Check fingerprint and setup 'stable' repo\n"
apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo -e "\n***** Install Docker-ce\n"
sudo apt update
sudo apt install docker-ce

echo -e "Enter user name to add to docker: "
read user

echo -e "\n*****\nCheck that user was added to sudo group\n"
sudo usermod -aG docker $user
cat /etc/group | grep docker
groups $user
echo -e "*****\n\n"

echo -e "\n***** Run Hello World Test\n"
docker run hello-world

echo -e "\n*****\nPython and Docker installed\n*****"
