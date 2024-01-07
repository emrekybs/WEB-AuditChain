#!/bin/bash
#!Author Emrekybs

echo -e "									      " | lolcat
echo -e " 		    WEB-Application Audit                                     " | lolcat
echo -e "      			Emre Koybasi                                          " | lolcat
echo -e "		 https://github.com/emrekybs                                  " | lolcat
echo -e " 		https://www.linkedin.com/in/emre-koybasi/                     " | lolcat
echo -e "        =======================================================	      " | lolcat
echo -e "      🕷   |  🕷                                                             " | lolcat
echo -e "      /   |   \                                                              " | lolcat
echo -e "     / /  |  \ \                                                             " | lolcat
echo -e "     \ \_(*)_/ /                                                             " | lolcat
echo -e "      \_(~:~)_/                                                              " | lolcat
echo -e "       /-(:)-\                                                               " | lolcat
echo -e "      / / * \ \                                                              " | lolcat
echo -e "      \ \   / /                                                              " | lolcat
echo -e "       \     /                                                               " | lolcat
echo -e "       🕷 WEB🕷                                                              " | lolcat


RED_LINE="${RED}================================================================================${NC}"

command -v lolcat > /dev/null 2>&1 || { echo >&2 "lolcat not installed. If install: sudo apt-get install lolcat"; exit 1; }

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NC=$(tput sgr0)
BLUE=$(tput setaf 4)
echo -e "\n"

echo -e "${BLUE}╔════════════════════════════════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║ This tool is designed for comprehensive recon and enumeration on web sites and target domains. ║${NC}"
echo -e "${BLUE}║ It employs various techniques and tools for DNS discovery, subdomain scanning, open ports and  ║${NC}"
echo -e "${BLUE}║ services detection, and directory structure analysis, enabling detailed information gathering  ║${NC}"
echo -e "${BLUE}║ on target sites.                                                                               ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════════════════════════════════════╝${NC}"



mkdir -p Results

echo -e "\n\n"

echo -e "${RED}Please enter the target domain (example: domain.com):${NC}"

# Kullanıcıdan domain girmesini iste
read -p "${GREEN}Target Website->> ${NC}" domain


# Whois
figlet WHOIS | lolcat
sleep 2
whois $domain | tee Results/whois.txt 
echo "${BLUE}Scan complete. Results in 'Results/whois.txt'.${NC}"
echo -e "$RED_LINE"

figlet WEB-TECH | lolcat
whatweb www.$domain | tee Results/whatweb.txt
echo  "${BLUE}Scan complete. Results in 'Results/web-tech.txt'.${NC}"
echo -e "$RED_LINE"

wafw00f www.$domain | tee Results/waf.txt
echo -e "${BLUE}Scan complete. Results in 'Results/waf.txt'.${NC}"
echo -e "$RED_LINE"

#Check Sslscan
figlet SSLSCAN | lolcat
sleep 1
sslscan $domain | tee Results/Sslscan.com
echo -e "${BLUE}Scan complete. Results in 'Results/Sslscan.txt'.${NC}"
echo -e "$RED_LINE"

#E-Mail
emailfinder -d $domain | tee Results/E-Mails.txt
echo -e "${BLUE}Scan complete. Results in 'Results/E-Mails.txt'.${NC}"
echo -e "$RED_LINE"

# Dnsrecon
figlet DNSrecon | lolcat
sleep 1
dnsrecon -d $domain -t std,axfr | tee Results/DNSrecon.txt
echo -e "${BLUE}Scan complete. Results in 'Results/DNSrecon.txt'.${NC}"
echo -e "$RED_LINE"

# Subfinder subdomain enumeration
subfinder -d $domain -o Results/subdomains.txt | lolcat
echo  "${BLUE}Scan complete. Results in 'Results/subdomains.txt'.${NC}"
echo -e "$RED_LINE"

# subfinder ile domain taraması yap ve sessiz modda çalıştır
subfinder -d $domain -silent | httpx -title -tech-detect -status-code -o Results/httpx.txt
echo "${BLUE}Scan complete. Results in 'Results/httpx.txt'.${NC}"
echo -e "$RED_LINE"

# Naabu PortScan 
naabu -host $domain -o Results/openports.txt | lolcat
echo "${BLUE}Scan complete. Results in 'Results/openports.txt'.${NC}"
echo -e "$RED_LINE"

# DNSX Portscan
subfinder -d $domain -silent | dnsx -a -ro | sort -u | naabu -silent | tee Results/Subdomains_IPs_Ports.txt | lolcat
echo "${BLUE}Scan complete. Results in 'Results/Subdomains_IPs_Ports.txt'.${NC}"
echo -e "$RED_LINE"

# DNSTAKEOVER
subfinder -silent -d $domain | dnstake 2>&1 | tee Results/DNS_Takeover_Report.txt
echo "${BLUE}Scan complete. Results in 'Results/DNS_Takeover_Report.txt'.${NC}"
echo -e "$RED_LINE"

# Katana next-generation crawling and spidering framework
subfinder -silent -d $domain | httpx -silent | katana -o Results/katana.txt
echo "${BLUE}Scan complete. Results in 'Results/Katana.txt'.${NC}"
echo -e "$RED_LINE"

# GoSpider-Fast Web Spider
figlet Go Web-Spider | lolcat
gospider -s https://$domain -o Results/Go-WebSpider -c 10 -d 1 --robots 
echo "${BLUE}Scan complete. Results in 'Results/Go-WebSpider'.${NC}"
echo -e "$RED_LINE"

# Metagoofil Extraction Metadata
figlet Metagoofil | lolcat
metagoofil -d $domain -t pdf -l 200 -n 100 -o Results/metagoofil -f Results/metagoofil.html 
echo "${BLUE}Scan complete. Results in 'Results/metagoofil.html'.${NC}"
echo -e "$RED_LINE"

echo -e "${GREEN}ALL Scan is Completed !${NC}"
echo -e "${GREEN}<--By Emre Koybasi--> !${NC}"

