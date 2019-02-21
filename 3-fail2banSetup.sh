#!/bin/bash
echo -e "*****\nFAIL2BAN INTRUSTION PROTECTION SETUP\n*****\n"
if ((${EUID:-0} || "$(id -u)")); then echo "\nERROR: Needs to be run as root."; exit 100; fi

echo -e "\n***** Installing Fail2Ban"
# Install needed packages
apt install fail2ban

echo -e "\n***** Modifying Fail2Ban Settings\n"
echo -e "$ vi /etc/fail2ban/jail.local\n"
# Change to permanently ban if 7+ logins to SSH
echo -e "# 1-Day-Ban upon 7+ tries\n[DEFAULT]\nbantime = 86400\n\n[sshd]\nenabled = true\nport = ssh\nfilter = sshd\nlogpath = /var/log/auth.log\nmaxretry = 7" > /etc/fail2ban/jail.local

echo -e "\n***** Start Fail2Ban Service"
# Start Fail2Ban service
systemctl start fail2ban
systemctl enable fail2ban
fail2ban-client reload

echo -e "\n$ fail2ban-client status sshd\n"
fail2ban-client status sshd

echo -e "\n*****\nFail2ban changed to ban for 1-day after 7+ tries\nTHIS INCLUDES YOURSELF!\nTo remove ban, login via KVM and run this: fail2ban-client set sshd unbanip 108.45.25.217\n*****"
