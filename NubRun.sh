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
	figlet "Nubuilder" | lolcat
	figlet "Run Script" | lolcat
	echo -e "\e[32mVersion 1.0 for Parrot Home, Parrot Security OS, and Kali Linux\e[0m"
	echo -e "\e[32mVisit my youtube channel Majik Cat Security\e[0m"
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

#=================================
#          RUN SCRIPT            #
#=================================

echo "Checking Sql Server..." | lolcat
sleep 3
sqlstat=$(systemctl status mariadb)
if [[ $sqlstat == *"active (running)"* ]]; then
    echo "Mariadb is running" | lolcat
else
    systemctl start mariadb
    sleep 8
fi
echo "Checking Apache Server..." | lolcat
sleep 3
servstat=$(systemctl status apache2)
if [[ $servstat == *"active (running)"* ]]; then
	echo "Apache2 is running" | lolcat
else 
	systemctl start apache2
	sleep 8
fi

if [[ $servstat && $sqlstat == *"active (running)"* ]]; then
	echo "Opening Nubuilder in default browser" | lolcat
	sleep 3
	xdg-open http://localhost/nubuilder
else
	echo "There is a problem with either the Apache Server or the SQL Server!" | lolcat
	sleep 3
	echo "Stopping Script..." | lolcat
	sleep 3
fi
