#!/bin/bash
echo -e "*****\nMOTD TURN OFF (message upon SSH login)\n*****\n\n"
if ((${EUID:-0} || "$(id -u)")); then echo "ERROR: Needs to be run as root."; exit 100; fi

chmod -x /etc/update-motd.d/*

echo -e "\n*****\nMOTD turned off\nTo turn MOTD back on: sudo chmod +x /etc/update-motd.d/*\n*****"
