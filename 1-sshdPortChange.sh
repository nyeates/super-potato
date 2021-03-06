#!/bin/bash
echo -e "*****\nSSHD PORT CHANGE\n*****\n"
if ((${EUID:-0} || "$(id -u)")); then echo "ERROR: Needs to be run as root."; exit 100; fi

port="777"

echo -e "***** Installing vim and ufw"
# Install needed packages
apt install vim
apt install ufw

echo -e "\n***** Changing SSHD port in config file"
echo -e "$ vim /etc/ssh/sshd_config"
echo -e "YOU WILL WANT TO ASSURE THAT THE PORT IN THE FILE ACTUALLY GETS AUTO-CHANED TO $port."
echo -e "Sometimes it doesnt because formatting is not as expected."
echo -e "Press Enter... "; read shit
# Change SSHD port in config file
vim -c '%s/Port 22/Port '"$port"'/c' -c 'wq' /etc/ssh/sshd_config
vi /etc/ssh/sshd_config

echo -e "\n***** Setting up firewall"
# Setup firewall
ufw allow $port/tcp
ufw limit $port/tcp
ufw delete limit ssh # remove old ssh port if it was there
ufw logging on
echo -e "Press Enter... "; read shit

echo -e "\n***** Restarting Firewall (ufw) and SSH service"
ufw enable
ufw status # check that old ports aren’t still open
# Restart SSHD service
echo -e "\n*****\nSSHD Changed to Port $port \nREMEMBER RECONNECT SSH ON PORT $port \n*****"
service sshd restart
