#!/bin/bash

PKG_OK=$(dpkg-query -W --showformat='${Status}\n' lolcat | grep "install ok installed")
echo Checking for lolcat: $PKG_OK
if [ "" == "$PKG_OK" ]; then
  echo -e "\e[35mlolcat not installed. Attempting to install lolcat now...\e[0m"
  sleep 0.15
  nala install lolcat
  gem install lolcat
fi

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
