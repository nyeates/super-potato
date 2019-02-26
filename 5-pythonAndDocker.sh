#!/bin/bash
echo -e "\n*****\nPYTHON AND DOCKER INSTALL\n*****\n"
if ((${EUID:-0} || "$(id -u)")); then echo "Running as user: $EUID $id"; else echo "ERROR: Needs to be run as NON ROOT."; exit 100; fi

echo -e "\n***** Intall required packages"
# Might need these
sudo apt install dirmngr gpg-agent gnupg-agent
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7EA0A9C3F273FCD8

echo -e "\n***** Install Python3"
sudo apt install python3
sudo apt install python3-pip

echo -e "\n***** Install pre-req packages"
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo -e "\n***** Check fingerprint and setup 'stable' repo"
apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo -e "\n***** Install Docker-ce"
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io

echo -e "\n***** Add user to docker group"
echo -e "Enter user name to add to docker: "
read user

echo -e "\n*****\nCheck that user was added to sudo group"
sudo usermod -aG docker $user
cat /etc/group | grep docker
groups $user
echo -e "*****\n"

echo -e "\n***** Run Hello World Test"
docker run hello-world

echo -e "\n*****\nPython and Docker installed\n*****"
