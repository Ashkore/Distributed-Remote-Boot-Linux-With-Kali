#!/usr/bin/env bash
#Color Variables
Green='\033[0;32m'
LGreen='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'

#Check if any Parameters are NULL
if [ -z "$1" ]; then
    echo "${RED}ERROR: Missing Parameter 1\nNIC not defined."
    exit 0;
elif [ -z "$2" ]; then
    echo "${RED}ERROR: Missing Parameter 2\nIP Address of DRBL ENV NIC not defined."
    exit 0;
elif [ -z "$3" ]; then
    echo "${RED}ERROR: Missing Parameter 3\nGateway of DRBL ENV not defined."
    exit 0;
fi

#Check if IP address is an ipv4 address, if so, set the network and broadcast variables
IFS=. read ip1 ip2 ip3 ip4 <<< $2
if [ -z $ip1 ] || [ -z $ip2 ] || [ -z $ip3 ] || [ -z $ip4 ]; then
    echo "${RED}ERROR: Incorrect Parameter 2\nIP address does not have 4 octets."
    exit 0;
else
    first3=$ip1"."$ip2"."$ip3
    network=$first3".0"
    broadcast=$first3".255"

    #Start of Networking setup
    echo "${LGreen}Starting: Setting up the /etc/network/interfaces File."
    echo "#THE DRBL ENVIRONMENT" >> /etc/network/interfaces
    echo "#This interface is for the NIC pointing to the DRBL network." >> /etc/network/interfaces
    echo "allow-hotplug $1" >> /etc/network/interfaces
    echo "iface $1 inet static" >> /etc/network/interfaces
    echo "address $2" >> /etc/network/interfaces
    echo "netmask 255.255.225.0" >> /etc/network/interfaces
    echo "network $network" >> /etc/network/interfaces
    echo "broadcast $broadcast" >> /etc/network/interfaces
    echo "gateway $3" >> /etc/network/interfaces
    echo "${Green}Finished: Setting up the /etc/network/interfaces File."
    #End of Networking setup

    echo "${LGreen}Starting: Restarting networking service."
    service networking restart
    echo "${Green}Finished: Restarting networking service."

    #Start of Repository setup
    echo "${LGreen}Starting: Setting up /etc/apt/sources.list File"
    echo "deb http://ftp.us.debian.org/debian/ jessie main" >> /etc/apt/sources.list
    echo "deb http://free.nchc.org.tw/drbl-core drbl stable" >> /etc/apt/sources.list
    echo "${Green}Finished: Setting up /etc/apt/sources.list File"
    #End of Repository setup

    #Start of Update OS
    echo "${LGreen}Starting: Updating OS"
    apt-get update -y && apt-get upgrade -y
    echo "${Green}Finished: Updating OS"
    #End of Update OS

    #Start of DRBL install
    echo "${LGreen}Starting: Installing DRBL"
    apt-get install drbl
    echo "${Green}Finished: Installing DRBL"
    #End of DRBL install

    #Start of DRBL Configuration
    echo "${LGreen}Starting: DRBL Configuration"
    printf 'N\nN\nN\n1\n' | drblsrv -i
    ###REDO THIS
    Setup FULL DRBL mode [0]
    Setup I do not want clonezilla[2]
    No to swapspace on thick client HDD
    graphic mode??? [1]
    normal login[0]
    security [n]
    pxe security[n]
    set boot prompt[y]
    how many [100]
    graphic background[y]
    usb stuff[y]
    ip stuff[n]
    terminal mode[n]
    nat server[y]

    echo "${LGreen}Finished: DRBL Configuration"
    #End of DRBL Configuration
fi