#!/bin/bash
echo -e "\n*****\nLink Repo to Github\n*****\n"
#if ((${EUID:-0} || "$(id -u)")); then echo "ERROR: Needs to be run as root."; exit 100; fi

echo -e "***** Set github name and email - it needs these to do commits in future"
echo -e "If you havent setup an email address already, use: git config --global user.email \"[EMAIL_HERE]\""
sudo apt install git
git config --global user.name "N"
git status

echo -e "\n***** Create USER account"

echo -e "\n***** Upgrade all Packages"

echo -e "\n*****\nGithub repo sync'ed\n*****\n"
echo -e "Important Git commands:"
echo -e "git status"
echo -e "git add *"
echo -e "git rm blah.sh"
echo -e "git commit (uses text editor for comment)"
echo -e "git commit -m "my changes"
echo -e "git push origin master"
echo -e "*****"