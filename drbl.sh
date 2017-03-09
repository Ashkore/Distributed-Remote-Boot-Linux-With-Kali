#!/usr/bin/env bash
#EXAMPLE:
#./drbl.sh
#Color Variables
Green='\033[0;32m'
LGreen='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'

#Start of Repository setup
echo -e "${LGreen}Starting: Setting up /etc/apt/sources.list File"
echo "deb http://ftp.us.debian.org/debian/ jessie main" >> /etc/apt/sources.list
echo "deb http://free.nchc.org.tw/drbl-core drbl stable" >> /etc/apt/sources.list
echo -e "${Green}Finished: Setting up /etc/apt/sources.list File"
#End of Repository setup

#Start of Update OS
echo -e "${LGreen}Starting: Updating OS"
echo -e "${NC}"
apt-get update -y && apt-get upgrade -y
echo -e "${Green}Finished: Updating OS"
#End of Update OS

#Start of DRBL install
echo -e "${LGreen}Starting: Installing DRBL"
echo -e "${NC}"
apt-get install drbl -y --allow-unauthenticated
echo -e "${Green}Finished: Installing DRBL"
#End of DRBL install


#WORK IN PROGRESS
echo -e "${LGreen}Starting: DRBL Configuration"

echo -e "${LGreen}Starting: DRBL package Installs"
echo -e "${NC}"
apt-get install drbl-chntpw freedos partclone clonezilla mkpxeinitrd-net -y --allow-unauthenticated
printf 'N\nN\nY\n1\n' | drblsrv -i
echo -e "${Green}Finished: DRBL package Installs"



exit 0;
echo -e "${LGreen}Starting: DRBL Client Setup"
echo -e "${NC}"
#Please Enter DNS Domain [drbl.org]
#Please enter NIS/YP domain name [penguinzilla]
#Please enter the client hostname prefix [DRBL-Server-]
#Public IP of this server [eth0]
#Collect MACaddresses? [N]
#DCHP in DRBL NIC offer same IP to each mac everytime [n]
#Inital number to use for ip [1] 10
#How many DRBL clients? [12] 20
#Correct IPS? [y]
#Press enter to continue
#Which DRBL mode? [0]
#Which clonezilla[0] 2
#Want to use the HDD Swap partition as swapfile [Y] N
#Which mode do you want the clients to use after they boot? [1]
#which mode do you want went client boots [0]
#Differnt root password for clients vs server? [N]
#PXE password [N]
#Boot Prompts for clients? [Y]
#How many 1/10 sec is the boot promt timeout for clients? [70]
#Graphic background for PXE menu? [Y]
#Let USb stuff work [y]
#public IP for cleints? [N]
#Terminal mode? [N]
#Let DRBL server as a NAT server? [Y]
#press enter to continue
#Continue[Y]

printf '\n\nKali-\n\n\n\n10\n20\n\n\n\n2\nN\n\n\n\n\n\n\n\n\n\n\n\n\n\n' | drblpush -i
echo -e "${Green}Finished: DRBL Client Setup"

echo -e "${Green}Finished: DRBL Configuration"
#End of DRBL Configuration
