#!/usr/bin/env bash
#Color Variables
Green='\033[0;32m'
LGreen='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'

#Check if any Parameters are NULL
if [ -z "$1" ]; then
    echo -e "${RED}ERROR: Missing Parameter 1\nDRBL NIC not defined."
    exit 0;
fi
if [ -z "$2" ]; then
    echo -e "${RED}ERROR: Missing Parameter 1\nOTHER NIC not defined."
    exit 0;
fi
if [ -z "$3" ]; then
    echo -e "${RED}ERROR: Missing Parameter 2\nIP Address of DRBL ENV NIC not defined."
    exit 0;
fi
if [ -z "$4" ]; then
    echo -e "${RED}ERROR: Missing Parameter 3\nGateway of DRBL ENV not defined."
    exit 0;
fi

#Check if IP address is an ipv4 address, if so, set the network and broadcast variables
IFS=. read ip1 ip2 ip3 ip4 <<< $3
if [ -z $ip1 ] || [ -z $ip2 ] || [ -z $ip3 ] || [ -z $ip4 ]; then
    echo -e "${RED}ERROR: Incorrect Parameter 2\nIP address does not have 4 octets."
    exit 0;
fi

DRBLNic=$1
OtherNic=$2
first3=$ip1"."$ip2"."$ip3
network=$first3".0"
broadcast=$first3".255"

#Start of Networking setup
echo -e "${LGreen}Starting: Setting up the /etc/network/interfaces File."
echo "#THE DRBL ENVIRONMENT" >> /etc/network/interfaces
echo "#This interface is for the NIC pointing to the DRBL network." >> /etc/network/interfaces
echo "allow-hotplug $DRBLNic" >> /etc/network/interfaces
echo "iface $DRBLNic inet static" >> /etc/network/interfaces
echo "address $3" >> /etc/network/interfaces
echo "netmask 255.255.225.0" >> /etc/network/interfaces
echo "network $network" >> /etc/network/interfaces
echo "broadcast $broadcast" >> /etc/network/interfaces
echo "gateway $4" >> /etc/network/interfaces
ifup $DRBLNic
echo -e "${Green}Finished: Setting up the /etc/network/interfaces File."
#End of Networking setup

echo -e "${LGreen}Starting: Restarting networking service."
service networking restart
echo -e "${Green}Finished: Restarting networking service."

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





exit 0;

#WORK IN PROGRESS
echo -e "${LGreen}Starting: DRBL Configuration"

echo -e "${LGreen}Starting: DRBL package Installs"
apt-get install drbl-chntpw freedos partclone clonezilla mkpxeinitrd-net -y --allow-unauthenticated
printf 'N\nN\nY\n1\n' | drblsrv -i
echo -e "${LGreen}Finished: DRBL package Installs"

echo -e "${LGreen}Starting: DRBL Client Setup"
#Please Enter DNS Domain [drbl.org]
#Please enter NIS/YP domain name [penguinzilla]
#Please enter the client hostname prefix [DRBL-Server-]
#Public IP of this server [eth0]
echo '\n\n\n$OtherNIC\n'
printf '\n\n\n$OtherNIC\n' | drblpush -i




echo -e "${LGreen}Finished: DRBL Client Setup"

echo -e "${LGreen}Finished: DRBL Configuration"
#End of DRBL Configuration
