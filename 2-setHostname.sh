#!/bin/bash
if ((${EUID:-0} || "$(id -u)")); then echo "ERROR: Needs to be run as root."; exit 100; fi
echo -e "\n*****\nSET HOSTNAME\n*****\n"

oldHostname=$(hostname -s)
echo -e "oldHostname = $oldHostname\n"

echo -e "***** Set Hostname"
echo -e "Enter the hostname you would like to use: "
read newHostname

hostnamectl set-hostname $newHostname
echo -e "\n$ hostnamectl set-hostname $newHostname\nPress Enter... "; read shit

# Add new hostname to /etc/hosts
echo -e "YOU WILL NEXT ENTER VI TEXT EDITOR AND ADD/EDIT A LINE FOR THE NEW HOSTNAME\n"
echo -e "THE 2nd LINE NEEDS TO LOOK SIMILAR TO BELOW. YOU MAY WANT TO COPY THE 2nd LINE, SO THAT YOU CAN REPLICATE IT."
echo -e "To edit, write, and close vi, you will need to know its commands..."
echo -e "================="
echo -e "127.0.0.1       localhost"
echo -e "78.31.64.253    vps1836265.fastwebserver.de bb-8"
echo -e "================="
echo -e "$ vim /etc/hosts"
echo -e "Press Enter... "; read shit

# https://askubuntu.com/questions/950017/how-to-substitute-the-nth-occurrence-pattern-in-vi-editor
#vim -c ':2s/\(.\{-}\zs'"$oldHostname"'\)\{2}/'"$newHostname"'/' -c 'wq' /etc/hosts
#sudo vim -c ':2s/\(.\{-}\zs'$oldHostname'\)\{2}/'$newHostname'/' -c 'wq' /etc/hosts
sudo vim /etc/hosts

# Show /etc/hosts file
echo -e "\n***** /etc/hosts file:"
cat /etc/hosts
echo -e "*****\n"

commandResult=$?
if [ $commandResult -eq 0 ]; then
	echo -e "\n*****\nHostname Changed to $newHostname\n*****"
else
	echo -e "HOSTNAME NOT CHANGED. PLEASE CHECK /etc/hosts FILE"
	# insert new line to end of /etc/hosts file
	#echo "" >> /etc/hosts
	# DONT NEED THIS YET, as no error yet
fi
