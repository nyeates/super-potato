#!/bin/bash
echo -e "\n*****\nTMN INSTALL\n*****\n"
if ((${EUID:-0} || "$(id -u)")); then echo "Running as user: $EUID $id"; else echo "ERROR: Needs to be run as NON ROOT."; exit 100; fi

echo -e "\n***** Run Hello World Test"
docker run hello-world
echo -e "Press Enter... "; read shit

echo -e "\n***** Installing Pre-req Packages"
sudo apt-get install python3-setuptools
pip3 install wheel
# sudo apt install build-essential
# sudo apt install python3-dev
echo -e "Press Enter... "; read shit

echo -e "\n***** Installing and updating tmn pip3 package"
pip3 install --user tmn
pip3 install -U tmn
echo -e "Press Enter... "; read shit

echo -e "\n***** Tmn Details:"
pip3 show tmn

echo -e "\n*****\ntmn has been installed\n*****"
