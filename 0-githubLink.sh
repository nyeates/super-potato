#!/bin/bash
echo -e "\n*****\nGITHUB SETUP\n*****\n"
#if ((${EUID:-0} || "$(id -u)")); then echo "ERROR: Needs to be run as root."; exit 100; fi

email="213291+nyeates@users.noreply.github.com"
name="N"

sudo apt install git

echo -e "\n***** Set github name and email"
echo -e "Git needs both a name and email address to do commits in the future."
git config --global user.email "$email"
git config --global user.name "$name"
echo -e "user.email set to $email"
echo -e "user.name set to $name"
echo -e "*****\n"

git status

echo -e "\n*****\nGithub repo sync'ed\n*****\n"

echo -e "*****"
echo -e "Important Git commands:"
echo -e "git status"
echo -e "git add *"
echo -e "git rm blah.sh\n"
echo -e "git commit"
echo -e "git commit -m \"my changes\"\n"
echo -e "git push origin master"
echo -e "  Note: If you have 2fa setup, you will need the SSH token instead of password"
echo -e "*****"
