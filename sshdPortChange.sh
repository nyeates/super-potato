#!/bin/bash
echo -e "*****\nSSHD PORT CHANGE\n*****\n\n"
if ((${EUID:-0} || "$(id -u)")); then echo "ERROR: Needs to be run as root."; exit 100; fi

port="777"

# Install needed packages
apt install vim
apt install ufw

# Change SSHD port in config file
vim -c '%s/#Port 22/Port '"$port"'/c' -c 'wq' /etc/ssh/sshd_config

# Setup firewall
ufw allow $port/tcp
ufw limit $port/tcp
ufw delete limit ssh # remove old ssh port if it was there
ufw logging on
ufw enable
ufw status # check that old ports aren’t still open

# Restart SSHD service
echo -e "\n*****\nSSHD Changed to Port $port \nREMEMBER TO EXIT AND RECONNECT ON PORT $port \n*****"
service sshd restart
