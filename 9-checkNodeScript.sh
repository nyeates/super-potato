#!/bin/bash
# Checks that tomo masternodes and rewards are coming through as they should
# https://github.com/tomochain/docs/wiki/Jesse's-%22checknode%22-Monitoring-Script
if ((${EUID:-0} || "$(id -u)")); then echo "Running as user: $EUID $id"; else echo "ERROR: Needs to be run as NON ROOT. Same user where masternode installed on."; exit 100; fi

echo -e "\n*****\nSETUP CHECK-NODE SCRIPT\n*****\n"

echo -e "Assure that a proper hostname is set and that this installation is run as the same user where tomo masternode was installed."
echo -e "\033[1mYour current hostname: $(hostname -s)\033[0m"
echo -e "Press Enter... "; read shit

echo -e "*****\nInstall needed packages "
sudo apt install ssmtp jq
echo -e "Press Enter... "; read shit

echo -e "***** Editing /etc/ssmtp/ssmtp.conf to set sSMTP settings"
# Comment out all lines
# https://unix.stackexchange.com/questions/47486/comment-all-lines-in-a-text-file
sudo vim -c '%s/^/#/' -c 'wq' /etc/ssmtp/ssmtp.conf

# Add settings at end of file
echo "Enter the gmail email address that will send out texts/emails (ex: smapleton@gmail.com): "; read email
echo "Enter the password for the above email address: "; read password
echo -e "\nContent written to /etc/ssmtp/ssmtp.conf: "
# https://unix.stackexchange.com/questions/4335/how-to-insert-text-into-a-root-owned-file-using-sudo
echo -e "root=$email\nmailhub=smtp.gmail.com:587\nAuthUser=$email\nAuthPass=$password\nUseSTARTTLS=YES" | sudo tee -a /etc/ssmtp/ssmtp.conf

echo -e "\n***** Test that email works"
echo -e "Following command run: "
# FIXME could put a loop in to keep allowing testing until it works and you get an email; assure error msgs show
echo -e "\033[1mecho \"test email from $(hostname -s)\" | ssmtp $email\033[0m"
echo "test email from $(hostname -s)" | ssmtp $email
echo -e "\nDid you get an email at $email ? "; read emailTest

echo "Please enter your Verizon phone number that will receive SMS (ex: 2039871756): "; read verizonNum
phone="$verizonNum@vtext.com"
echo "Full Verizon phone-email: $phone"
printf "Subject: TEST\n\nTest text message from $(hostname -s)" | /usr/sbin/ssmtp $phone
echo -e "\nDid you get a text message? "; read textTest

#echo -e "\n*****\nTomo Check-node setup and functioning. Test with:\n"
#echo -e "\033[1mBLAHBLAHLBAH\033[0m\n"
