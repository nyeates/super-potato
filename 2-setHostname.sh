#!/bin/bash
echo -e "\n*****\nSET HOSTNAME\n*****\n"
if ((${EUID:-0} || "$(id -u)")); then echo "ERROR: Needs to be run as root."; exit 100; fi

echo -e "***** Set Hostname"
echo -e "Enter the hostname you would like to use: "
read newHostname
hostnamectl set-hostname $newHostname

# Add new hostname to /etc/hosts
echo -e "$ vi /etc/hosts\n"
$oldHostname = $(hostname -s)
# https://askubuntu.com/questions/950017/how-to-substitute-the-nth-occurrence-pattern-in-vi-editor
vim -c ':2s/\(.\{-}\zs'"$oldHostname"'\)\{2}/'"$newHostname"'/' -c 'wq' /etc/hosts
echo -e "Press Enter... "; read shit

# Restart SSHD service
echo -e "\n*****\nHostname Changed to $newHostname\n*****""
