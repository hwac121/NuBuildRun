#!/bin/bash

# Title: Nubuild Run Script
# Version: 1.0
# Date: Oct. 12, 2024
# Contact: hwac121@ptorbox.onion

# GitHub: https://github.com/hwac121/NubBuildRun.git

#-----------------------------------------------------------------

# Description:
# A simple script to check if SQL DB and Apache web server is running,
# if not it they will be started and then Nubuilder will be opened in
# your default browser. This has only been tested on Parrot Security 
# and Kali Linux systems.

#=======================================================================
#                         FUNCTIONS
#=======================================================================

splash(){
	echo -e "\e[33mNubRun\e[0m"
	echo -e "\e[32mVersion 1.0 for Parrot Home, Parrot Security OS, and Kali Linux\e[0m"
	echo -e "\e[32mby Majik Cat Security\e[0m"
}

#==================================
#         CHECK IF ROOT           #
#==================================

if [ "$EUID" -ne 0 ]
  then 
	clear
	splash
	echo " "
	echo -e "\e[35mMust be run as root\e[0m"
	sleep 0.5
  exit
fi

#==================================
#         SETUP SCRIPT            #
#==================================

PKG_OK=$(dpkg-query -W --showformat='${Status}\n' figlet | grep "install ok installed")
echo Checking for figlet: $PKG_OK
if [ "" == "$PKG_OK" ]; then
  echo -e "\e[35mfiglet not installed. Attempting to install figlet now...\e[0m"
  sleep 0.15
  apt install figlet
fi

PKG_OK=$(dpkg-query -W --showformat='${Status}\n' lolcat | grep "install ok installed")
echo Checking for lolcat: $PKG_OK
if [ "" == "$PKG_OK" ]; then
  echo -e "\e[35mlolcat not installed. Attempting to install lolcat now...\e[0m"
  sleep 0.15
  nala install lolcat
  gem install lolcat
fi

rm /usr/bin/nubrun
cp NubRun.sh /usr/bin/nubrun
chmod +x /usr/bin/nubrun
echo "Nubuilder Run Script is setup"
sleep 5
