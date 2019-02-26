#!/bin/bash
echo -e "\n*****\nLink Repo to Github\n*****\n"
#if ((${EUID:-0} || "$(id -u)")); then echo "ERROR: Needs to be run as root."; exit 100; fi

echo -e "***** Set github name and email"
echo -e "Git needs both a name and email address to do commits in the future.
echo -e "*****"

sudo apt install git
git config --global user.email "213291+nyeates@users.noreply.github.com"
git config --global user.name "N"
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
echo -e "*****"
