#!/bin/bash

# See Main Execution below the following functions...

# Just display helpful commands
display_help ()
{
	echo -e "\n*****"
	echo -e "NEXT STEPS AND HELPFUL COMMANDS:"
	echo -e "\n"
	echo -e "Run create-tomochain-masternode with the name of your masternode as argument:"
	echo -e "\033[1mcreate-tomochain-masternode Atlantis\033[0m"
	echo -e "\n"
	echo -e "Check to see what block has been processed and how many peers your connected to:"
	echo -e "docker exec \$(docker ps -q -f \"name=tomochain\") tomo attach /tomochain/data/tomo.ipc --exec \"eth.blockNumber\""
	echo -e "docker exec \$(docker ps -q -f \"name=tomochain\") tomo attach /tomochain/data/tomo.ipc --exec \"net.peerCount\""
	echo -e "\n"
	echo -e "Important docker-compose commands:"
	echo -e "# Upgrade create-tomochain-masternode (in case new version has come out)"
	echo -e "pip3 install -U create-tomochain-masternode"
	echo -e "*****"
}

# Install and prepare docker-compose tool
run_script ()
{
	# from https://docs.docker.com/compose/install/
	echo -e "\n*****\nDOCKER COMPOSE\n*****\n"
	if ((${EUID:-0} || "$(id -u)")); then echo "Running as user: $EUID $id"; else echo "ERROR: Needs to be run as NON ROOT."; exit 100; fi

	echo -e "\n***** download docker-compose"
	sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	echo -e "Press Enter... "; read shit

	echo -e "\n***** Installing Pre-req Packages"
	sudo apt install python3-setuptools
	sudo apt install python-pip
	pip3 install wheel
	# sudo apt install build-essential
	# sudo apt install python3-dev
	echo -e "Press Enter... "; read shit

	echo -e "\n***** Installing Docker-Compose"
	sudo chmod +x /usr/local/bin/docker-compose
	# Allow tab-completion of docker-compose commands
	sudo curl -L https://raw.githubusercontent.com/docker/compose/1.24.1/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
	docker-compose --version
	echo -e "Press Enter... "; read shit

	echo -e "\n***** Installing and updating create-tomochain-masternode pip3 package"
	pip3 install --user create-tomochain-masternode
	# Upgrade CTM pip install (in case new version has come out)
	pip3 install -U create-tomochain-masternode
	echo -e "Press Enter... "; read shit

	echo -e "\n***** create-tomochain-masternode Details:"
	pip3 show create-tomochain-masternode
	echo -e "Press Enter... "; read shit

	echo -e "\n***** Assure \$PATH env-variable contains /home/[user]/.local/bin :"
	echo "export PATH=$PATH:$HOME/.local/bin" >> $HOME/.bashrc
	source $HOME/.bashrc
	echo $PATH
	echo -e "Press Enter... "; read shit

	echo -e "\n*****\nCREATE-TOMOCHAIN-MASTERNODE has been installed\n*****"
	
	display_help
}

# Main Execution
# If an argument containing "?" is passed when this shell script is run
# This allows us to run as "0-githubLink.sh ?" and get only the command info back
# https://superuser.com/questions/186272/check-if-any-of-the-parameters-to-a-bash-script-match-a-string

if [[ $@ =~ "?" ]]; then
        display_help
        exit
else
        run_script
        exit
fi
