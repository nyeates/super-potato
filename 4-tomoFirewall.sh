#!/bin/bash
echo -e "*****\nTOMO FIREWALL SETUP\n*****"
if ((${EUID:-0} || "$(id -u)")); then echo "\nERROR: Needs to be run as root."; exit 100; fi

# Tomo port - used for talking to and from other node clients
port="30303"

echo -e "\n***** Install Firewall (ufw)"
# Install needed packages
apt install ufw

echo -e "\n***** Configuring firewall ports specific to Tomo"
# Configure firewall
ufw allow $port/tcp # add tomo port
ufw allow $port/udp # add tomo port
ufw logging on
ufw enable
ufw status # check that old ports aren’t still open

echo -e "\n*****\nTOMO port $port opened\n*****"
