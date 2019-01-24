#!/bin/bash
echo -e "*****\nFAIL2BAN INTRUSTION PROTECTION SETUP\n*****\n\n"
if ((${EUID:-0} || "$(id -u)")); then echo "ERROR: Needs to be run as root."; exit 100; fi
# Install needed packages
apt install fail2ban
# Change to permanently ban if 7+ logins to SSH
echo -e "# Permanently ban 7+ tries\n[DEFAULT]\nbantime = -1\n\n[sshd]\nenabled = true\nport = ssh\nfilter = sshd\nlogpath = /var/log/auth.log\nmaxretry = 7" > /etc/fail2ban/jail.local
# Start Fail2Ban service
systemctl start fail2ban
systemctl enable fail2ban
fail2ban-client reload
fail2ban-client status sshd
echo -e "\n*****\nFail2ban changed to *permanently* ban 7+ tries\nTHIS INCLUDES YOURSELF!\n*****”
