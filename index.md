# DRBL Documentation

## Tools
```
VMware Workstation
Kali Linux 64 Bit 2016.2 OS 
```
## Working Client OS's/Config Required
```
None ATM
```
## Info
The idea is to set up a DRBL virtual server and then create clients to boot off the server. The server will be Debian and I want to try to create multiple OS's for the clients to boot from. 
## Server Steps
### 1. Install the Server Os

```
Created a virtual server with:
    RAM: 4GB
    HDD: 100GB
    CPU: 2
    OS: Kali Linux 64 Bit 2016.2 OS 
    Nic1: NAT/ Or pointing to the Public Internet
    Nic2: Host Only/ Custom NIC / Or pointing to the NIC of the DRBL environment.

Followed Default Steps to install the os.
root:toor
```
I take a snapshot here since it is a virtual machine. [Fresh Install]
### 2. Script to install packages
```
Download the Script
root@kali:~# wget https://ashkore.github.io/Distributed-Remote-Boot-Linux-With-Kali/drbl.sh
root@kali:~# chmod +x drbl.sh
#./bash.sh (Network pointing to DRBL ENV) (IP address of DRBL ENV NIC) (Gateway of DRBL ENV)
root@kali:~# ./bash.sh eth1 192.168.111.2 192.168.111.1




```
# !!!!!Stopped on step 3!!!!!

