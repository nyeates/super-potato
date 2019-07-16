#!/bin/bash
echo -e "\n*****\nPYTHON AND DOCKER INSTALL\n*****\n"
if ((${EUID:-0} || "$(id -u)")); then echo "Running as user: $EUID $id"; else echo "ERROR: Needs to be run as NON ROOT."; exit 100; fi

echo -e "\n***** Intall required packages"
# Might need these
sudo apt install dirmngr
sudo apt install gnupg-agent
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7EA0A9C3F273FCD8
echo -e "Press Enter... "; read shit

echo -e "\n***** Install Python3"
sudo apt install python3
sudo apt install python3-pip
echo -e "Press Enter... "; read shit

echo -e "\n***** Install pre-req packages"
sudo apt update
sudo apt install apt-transport-https
sudo apt install ca-certificates
sudo apt install curl
sudo apt install software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo -e "Press Enter... "; read shit

echo -e "\n*****\nCHECK fingerprint and setup 'stable' repo"
echo -e "\n***** Key results should look like:  9DC8 5822 .... 0EBF CD88"
apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
echo -e "*****\n"
echo -e "Press Enter... "; read shit

echo -e "\n***** Install Docker-ce"
sudo apt update
sudo apt install docker-ce
sudo apt install docker-ce-cli
sudo apt install containerd.io
echo -e "Press Enter... "; read shit

echo -e "\n***** Add user to docker group"
echo -e "Enter user name to add to docker: "
read user

echo -e "\n*****\nCHECK that user was added to sudo group"
sudo usermod -aG docker $user
cat /etc/group | grep docker
groups $user
echo -e "*****\n"
echo -e "Press Enter... "; read shit

echo -e "\n***** Run Hello World Test"
docker run hello-world

echo -e "\n***** IF HELLO-WORLD DOESNT RUN, MAY NEED TO EXIT SHELL AND LOG BACK IN\n"

echo -e "\n*****\nPython and Docker installed\n*****"
