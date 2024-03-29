#!/bin/bash

GREEN="\033[0;32m"
NC="\033[0m" # No Color


echo -e "${GREEN}Updating package lists...${NC}"
sudo apt update


if ! command -v go > /dev/null 2>&1; then
    echo -e "${GREEN}Installing golang...${NC}"
    sudo apt-get install -y golang
fi

# Adding Go bin directory to PATH if it's not already included
GO_BIN_PATH="$HOME/go/bin"
if [[ ":$PATH:" != *":$GO_BIN_PATH:"* ]]; then
    echo -e "${GREEN}Adding Go bin directory to PATH...${NC}"
    export PATH=$PATH:$GO_BIN_PATH
    echo "export PATH=$PATH:$GO_BIN_PATH" >> ~/.bashrc
    # Also adding to .zshrc if it exists
    [ -f ~/.zshrc ] && echo "export PATH=$PATH:$GO_BIN_PATH" >> ~/.zshrc
fi


echo -e "${GREEN}Starting the installation of the WEB Application Audit Tool...${NC}"


echo -e "${GREEN}Checking and installing required packages...${NC}"


if ! command -v lolcat > /dev/null 2>&1; then
    echo -e "${GREEN}Installing lolcat...${NC}"
    sudo apt-get install -y lolcat
fi


if ! command -v figlet > /dev/null 2>&1; then
    echo -e "${GREEN}Installing figlet...${NC}"
    sudo apt-get install -y figlet
fi


if ! command -v whois > /dev/null 2>&1; then
    echo -e "${GREEN}Installing whois...${NC}"
    sudo apt-get install -y whois
fi


if ! command -v whatweb > /dev/null 2>&1; then
    echo -e "${GREEN}Installing whatweb...${NC}"
    sudo apt-get install -y whatweb
fi


if ! command -v wafw00f > /dev/null 2>&1; then
    echo -e "${GREEN}Installing wafw00f...${NC}"
    sudo apt-get install -y wafw00f
fi


if ! command -v sslscan > /dev/null 2>&1; then
    echo -e "${GREEN}Installing sslscan...${NC}"
    sudo apt-get install -y sslscan
fi


if ! command -v dnsrecon > /dev/null 2>&1; then
    echo -e "${GREEN}Installing dnsrecon...${NC}"
    sudo apt-get install -y dnsrecon
fi


if ! command -v subfinder > /dev/null 2>&1; then
    echo -e "${GREEN}Installing subfinder...${NC}"
    sudo apt install subfinder -y
fi


if ! command -v metagoofil > /dev/null 2>&1; then
    echo -e "${GREEN}Installing metagoofil...${NC}"
    sudo apt install metagoofil -y
fi


if ! command -v naabu > /dev/null 2>&1; then
    echo -e "${GREEN}Installing naabu...${NC}"
    sudo apt install naabu -y
fi


echo -e "${GREEN}Installing emailfinder...${NC}"
sudo pip3 install emailfinder


echo -e "${GREEN}Installing Go-based tools...${NC}"

sudo go install github.com/jaeles-project/gospider@latest

sudo go install github.com/projectdiscovery/katana/cmd/katana@latest

sudo go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

sudo go install github.com/pwnesia/dnstake/cmd/dnstake@latest

sudo go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest

echo -e "${GREEN}Cloning the 'leaks' repository...${NC}"
sudo git clone https://github.com/emrekybs/leaks.git
cd leaks

echo -e "${GREEN}Installing 'leaks' script...${NC}"
sudo cp leaks.sh /usr/local/bin/leaks.sh
sudo chmod +x /usr/local/bin/leaks.sh

cd ..
rm -rf leaks

echo -e "${GREEN}The 'leaks' script has been installed successfully.${NC}"
clear

echo -e "${GREEN}Cloning the 'Uscrapper' repository...${NC}"
git clone https://github.com/z0m31en7/Uscrapper.git
cd Uscrapper/install/

echo -e "${GREEN}Running the installation script for 'Uscrapper'...${NC}"
chmod +x ./install.sh
./install.sh

echo -e "${GREEN}Copying 'Uscrapper-v2.0.py' to '/usr/local/bin' and renaming it to 'unscrapper'...${NC}"
sudo cp ../Uscrapper-v2.0.py /usr/local/bin/unscrapper
sudo chmod +x /usr/local/bin/unscrapper

sudo sed -i '1i #!/usr/bin/env python3' /usr/local/bin/unscrapper

cd ../..
rm -rf Uscrapper

echo -e "${GREEN}The 'Uscrapper' has been installed successfully.${NC}"
clear


echo -e "${GREEN}All dependencies have been installed.${NC}"

echo -e "${GREEN}Installation completed. You can now run the Web-AuditChain.sh${NC}"
