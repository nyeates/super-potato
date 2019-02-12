#!/bin/bash
echo -e "*****\nCreate Alternate User\n*****\n"
if ((${EUID:-0} || "$(id -u)")); then echo "ERROR: Needs to be run as root."; exit 100; fi

echo -n "Do you want to set a new passwd for the current root user (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo -e "Please type new password for current root user:\n"
    passwd
else
    echo -e "\n"
fi

echo -e "Enter new user name: "
read newUser
echo -e "\n"
adduser $newUser
usermod -aG sudo $newUser

# Check that user was added to sudo group
echo -e "\n*****\nCheck that user was added to sudo group\n"
cat /etc/group | grep sudo
groups $newUser
echo -e "*****\n\n"

apt update; apt upgrade

echo -e "\n*****\nAlternate User `$newUser` Created\n*****"
echo -e "Press ENTER to RESTART... "
read restart
reboot
