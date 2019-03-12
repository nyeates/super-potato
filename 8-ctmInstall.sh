#!/bin/bash
echo -e "\n*****\nDOCKER COMPOSE\n*****\n"
if ((${EUID:-0} || "$(id -u)")); then echo "Running as user: $EUID $id"; else echo "ERROR: Needs to be run as NON ROOT."; exit 100; fi

echo -e "\n***** download docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
echo -e "Press Enter... "; read shit

echo -e "\n***** Installing Pre-req Packages"
sudo apt install python3-setuptools
pip3 install wheel
# sudo apt install build-essential
# sudo apt install python3-dev
echo -e "Press Enter... "; read shit

echo -e "\n***** Installing Docker-Compose"
sudo chmod +x /usr/local/bin/docker-compose
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.23.2/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
docker-compose version
echo -e "Press Enter... "; read shit

echo -e "\n***** Installing and updating create-tomochain-masternode pip3 package"
pip3 install --user create-tomochain-masternode
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

echo -e "\n*****\ncreate-tomochain-masternode has been installed\nNext steps:\n"
echo -e "Run create-tomochain-masternode with the name of your masternode as argument:"
echo -e "\033[1mcreate-tomochain-masternode Atlantis\033[0m\n"
echo -e "docker exec \$(docker ps -q -f \"name=tomochain\") tomo attach /tomochain/data/tomo.ipc --exec \"eth.blockNumber\""
echo -e "docker exec \$(docker ps -q -f \"name=tomochain\") tomo attach /tomochain/data/tomo.ipc --exec \"net.peerCount\"\n*****"
