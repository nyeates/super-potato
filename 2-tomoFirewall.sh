#!/bin/bash
echo -e "*****\nTOMO FIREWALL SETUP\n*****\n\n"
if ((${EUID:-0} || "$(id -u)")); then echo "ERROR: Needs to be run as root."; exit 100; fi

# Tomo port - used for talking to and from other node clients
port="30303"

# Install needed packages
apt install ufw

# Configure firewall
ufw allow $port/tcp # add tomo port
ufw allow $port/udp # add tomo port
ufw logging on
ufw enable
ufw status # check that old ports aren’t still open

echo -e "\n*****\nTOMO port $port opened\n*****"
