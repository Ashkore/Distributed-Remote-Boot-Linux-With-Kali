#!/usr/bin/env bash
#./bash.sh (Network pointing to DRBL ENV) (IP address of DRBL ENV NIC) (Gateway of DRBL ENV)
#EXAMPLE
#./bash.sh eth1 192.168.111.2 192.168.111.1
#Check if any Parameters are NULL
if [ -z "$1" ]; then
    echo "ERROR: Missing Parameter 1\nNIC not defined."
    break;
elif [ -z "$2" ]; then
    echo "ERROR: Missing Parameter 2\nIP Address of DRBL ENV NIC not defined."
    break;
elif [ -z "$3" ]; then
    echo "ERROR: Missing Parameter 3\nGateway of DRBL ENV not defined."
    break;
fi

#Check if IP address is an ipv4 address, if so, set the network and broadcast variables
IFS=. read ip1 ip2 ip3 ip4 <<< $2
if [ -z $ip1 ] || [ -z $ip2 ] || [ -z $ip3 ] || [ -z $ip4 ]; then
    echo "ERROR: Incorrect Parameter 2\nIP address does not have 4 octets."
    break;
else
    first3=$ip1"."$ip2"."$ip3
    network=$first3".0"
    broadcast=$first3".255"

    #Start of Networking setup
    echo "Starting: Setting up the /etc/network/interfaces File."
    echo "#THE DRBL ENVIRONMENT" >> /etc/network/interfaces
    echo "#This interface is for the NIC pointing to the DRBL network." >> /etc/network/interfaces
    echo "allow-hotplug $1" >> /etc/network/interfaces
    echo "iface $1 inet static" >> /etc/network/interfaces
    echo "address $2" >> /etc/network/interfaces
    echo "netmask 255.255.225.0" >> /etc/network/interfaces
    echo "network $network" >> /etc/network/interfaces
    echo "broadcast $broadcast" >> /etc/network/interfaces
    echo "gateway $3" >> /etc/network/interfaces
    echo "Finished: Setting up the /etc/network/interfaces File."
    #End of Networking setup
    echo "Starting: Restarting networking service."
    service networking restart
    echo "Finished: Restarting networking service."

    #Start of Repository setup
    echo "Starting: Setting up /etc/apt/sources.list File"
    echo "deb http://ftp.us.debian.org/debian/ jessie main" >> /etc/apt/sources.list
    echo "deb http://free.nchc.org.tw/drbl-core drbl stable" >> /etc/apt/sources.list
    echo "Finished: Setting up /etc/apt/sources.list File"
    #End of Repository setup

    #Start of Update OS
    echo "Starting: Updating OS"
    apt-get update -y && apt-get upgrade -y
    echo "Finished: Updating OS"
    #End of Update OS

    #Start of DRBL install
    echo "Starting: Installing DRBL"
    apt-get install drbl
    echo "Finished: Installing DRBL"
    #End of DRBL install
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
fi