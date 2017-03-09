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
apt-get install drbl-chntpw freedos partclone clonezilla mkpxeinitrd-net -y --allow-unauthenticated
printf 'N\nN\nY\n1\n' | drblsrv -i
echo -e "${LGreen}Finished: DRBL package Installs"



exit 0;
echo -e "${LGreen}Starting: DRBL Client Setup"
#Please Enter DNS Domain [drbl.org]
#Please enter NIS/YP domain name [penguinzilla]
#Please enter the client hostname prefix [DRBL-Server-]
#Public IP of this server [eth0]
echo '\n\n\n$OtherNIC\n'
printf '\n\n\n  \n' | drblpush -i




echo -e "${LGreen}Finished: DRBL Client Setup"

echo -e "${LGreen}Finished: DRBL Configuration"
#End of DRBL Configuration
