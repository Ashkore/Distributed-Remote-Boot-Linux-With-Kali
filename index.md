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
### 2. Update, Upgrade and Dist-Upgrade
```
root@kali:~# apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y
```
I take a snapshot here since it is a virutal machine. [Updated]
### 3. Setup Network
```
root@kali:~# ifconfig

        eth0:   .....
            inet 192.168.116.129 netmask 255.255.255.0 broadcast 192.168.116.255
                .....
        eth1:
                .....
                
root@kali:~# nano /etc/network/interfaces
        # The lookpback network interface
        auto lo
        iface lo inet loopback
        
        # The NIC point to the Internet
        auto eth0
        iface eth0 inet dhcp
 
        # The DRBL NIC
        auto eth1
        allow-hotplug eth1
        iface eth1 inet static
            address 10.0.0.2
            netmask 255.255.255.0
            gateway 10.0.0.1
    
root@kali:~# ifup eth1
root@kali:~# ifconfig
        eth0:   .....
            inet 192.168.116.129 netmask 255.255.255.0 broadcast 192.168.116.255
                .....
        eth1:   .....
            inet 10.0.0.2 netmask 255.255.255.0 broadcast 10.0.0.255
                .....

```
### 4. Script to install packages
```
Download the Script
root@kali:~# wget https://ashkore.github.io/Distributed-Remote-Boot-Linux-With-Kali/drbl.sh
root@kali:~# chmod +x drbl.sh
    #./bash.sh (Network pointing to DRBL ENV) (IP address of DRBL ENV NIC) (Gateway of DRBL ENV)
root@kali:~# ./bash.sh eth1 192.168.111.2 192.168.111.1
```
# !!!!!Stopped on step 3!!!!!

