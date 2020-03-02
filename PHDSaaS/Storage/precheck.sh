#!/bin/bash

# Pre-requirements

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo You are not running as the root user.  Please try again with root privileges.;
    logger -t You are not running as the root user.  Please try again with root privileges.;
    exit 1;
fi;

# Detect Linux platform
platform='';  # platform for requesting package
runningPlatform='';   # platform of the running machine
majorVersion='';
platform_detect() {
 isRPM=1
 if !(type lsb_release &>/dev/null); then
    distribution=$(cat /etc/*-release | grep '^NAME' );
    release=$(cat /etc/*-release | grep '^VERSION_ID');
 else
    distribution=$(lsb_release -i | grep 'ID' | grep -v 'n/a');
    release=$(lsb_release -r | grep 'Release' | grep -v 'n/a');
 fi;
 if [ -z "$distribution" ]; then
    distribution=$(cat /etc/*-release);
    release=$(cat /etc/*-release);
 fi;

 releaseVersion=${release//[!0-9.]}
 case $distribution in
     *"Debian"*)
        platform='Debian_'; isRPM=0; runningPlatform=$platform;
        if [[ $releaseVersion =~ ^7.* ]]; then
           majorVersion='7';
        elif [[ $releaseVersion =~ ^8.* ]]; then
           majorVersion='8';
        elif [[ $releaseVersion =~ ^9.* ]]; then
           majorVersion='9';
        elif [[ $releaseVersion =~ ^10.* ]]; then
           majorVersion='10';
        fi;
        ;;

     *"Ubuntu"*)
        platform='Ubuntu_'; isRPM=0; runningPlatform=$platform;
        if [[ $releaseVersion =~ ^14.* ]]; then
           majorVersion='14.04';
        elif [[ $releaseVersion =~ ^16.* ]]; then
           majorVersion='16.04';
        elif [[ $releaseVersion =~ ^18.* ]]; then
           majorVersion='18.04';
        fi;
        ;;

     *"SUSE"* | *"SLES"*)
        platform='SuSE_'; runningPlatform=$platform;
        if [[ $releaseVersion =~ ^11.* ]]; then
           majorVersion='11';
        elif [[ $releaseVersion =~ ^12.* ]]; then
           majorVersion='12';
        elif [[ $releaseVersion =~ ^15.* ]]; then
           majorVersion='15';
        fi;
        ;;

     *"Oracle"* | *"EnterpriseEnterpriseServer"*)
        platform='Oracle_OL'; runningPlatform=$platform;
        if [[ $releaseVersion =~ ^5.* ]]; then
           majorVersion='5'
        elif [[ $releaseVersion =~ ^6.* ]]; then
           majorVersion='6';
        elif [[ $releaseVersion =~ ^7.* ]]; then
           majorVersion='7';
        elif [[ $releaseVersion =~ ^8.* ]]; then
           majorVersion='8';
        fi;
        ;;

     *"CentOS"*)
        platform='RedHat_EL'; runningPlatform='CentOS_';
        if [[ $releaseVersion =~ ^5.* ]]; then
           majorVersion='5';
        elif [[ $releaseVersion =~ ^6.* ]]; then
           majorVersion='6';
        elif [[ $releaseVersion =~ ^7.* ]]; then
           majorVersion='7';
        fi;
        ;;

     *"CloudLinux"*)
        platform='CloudLinux_'; runningPlatform=$platform;
        if [[ $releaseVersion =~ ^6.* ]]; then
           majorVersion='6';
        elif [[ $releaseVersion =~ ^7.* ]]; then
           majorVersion='7';
        fi;
        ;;

     *"Amazon"*)
        platform='amzn'; runningPlatform=$platform;
        if [[ $(uname -r) == *"amzn2"* ]]; then
           majorVersion='2';
        elif [[ $(uname -r) == *"amzn1"* ]]; then
           majorVersion='1';
        fi;
        ;;

     *"RedHat"* | *"Red Hat"*)
        platform='RedHat_EL'; runningPlatform=$platform;
        if [[ $releaseVersion =~ ^5.* ]]; then
           majorVersion='5';
        elif [[ $releaseVersion =~ ^6.* ]]; then
           majorVersion='6';
        elif [[ $releaseVersion =~ ^7.* ]]; then
           majorVersion='7';
        elif [[ $releaseVersion =~ ^8.* ]]; then
           majorVersion='8';
        fi;
        ;;

  esac
}
clear
platform_detect
PlatformL="${platform}${majorVersion}";


echo "Platform is $PlatformL"
echo "Installing/Updating curl, netcat, zip, unzip and lsof..."
if [[ $PlatformL == *"RedHat"* ]]; then
	sudo yum install curl nc lsof -y -q > /dev/null
	sudo yum install zip unzip -y -q > /dev/null

elif [[ $PlatformL == *"Ubuntu"* ]]; then
	sudo apt-get install curl netcat lsof -y -qq > /dev/null
	sudo apt-get install zip unzip -y -qq > /dev/null

elif [[ $PlatformL == *"SuSE"* ]]; then
	sudo zypper install -y curl netcat-openbsd lsof > /dev/null
	sudo zypper install -y zip unzip > /dev/null

elif [[ $PlatformL == *"Oracle"* ]]; then
	sudo yum install curl nc lsof -y -q > /dev/null
	sudo yum install zip unzip -y -q > /dev/null

elif [[ $PlatformL == *"CloudLinux"* ]]; then
	sudo yum install curl nc lsof -y -q > /dev/null
	sudo yum install zip unzip -y -q > /dev/null

elif [[ $PlatformL == *"amzn"* ]]; then
	sudo yum install curl nc lsof -y -q > /dev/null
	sudo yum install zip unzip -y -q > /dev/null

elif [[ $PlatformL == *"Debian"* ]]; then
	sudo apt-get install curl netcat lsof -y -qq > /dev/null
	sudo apt-get install zip unzip -y -qq > /dev/null
fi
echo -e "Installation/Update complete.\n"

# Pre-Variables

# DSaaS URLs
DSaaSURLs=("files.trendmicro.com" "gacl.trendmicro.com" "grid-global.trendmicro.com" "grid.trendmicro.com" "dsaas1100-en-census.trendmicro.com" "deepsecaas11-en.gfrbridge.trendmicro.com" 
"ds120-en.fbs25.trendmicro.com" "ds120-jp.fbs25.trendmicro.com" "deepsecurity1100-en.fbs25.trendmicro.com" "deepsecurity1100-jp.fbs25.trendmicro.com" "deepsecurity1000-en.fbs20.trendmicro.com"
"deepsecurity1000-jp.fbs20.trendmicro.com" "deepsecurity1000-sc.fbs20.trendmicro.com" "dsaas.icrc.trendmicro.com" "dsaas-en-f.trx.trendmicro.com" "dsaas-en-b.trx.trendmicro.com" "dsaas.url.trendmicro.com"
"sitesafety.trendmicro.com" "jp.sitesafety.trendmicro.com" "iaus.activeupdate.trendmicro.com" "iaus.trendmicro.com" "ipv6-iaus.trendmicro.com" "ipv6-iaus.activeupdate.trendmicro.com")

# DS AMI and On-Premise URLs
DSAMIandONPURLs=("files.trendmicro.com" "ds1200-en-census.trendmicro.com" "ds1200-jp-census.trendmicro.com" "ds1100-en-census.trendmicro.com" "ds1100-jp-census.trendmicro.com" "ds1020-en-census.trendmicro.com"
"ds1020-jp-census.trendmicro.com" "ds1020-sc-census.trendmicro.com" "ds1000-en.census.trendmicro.com" "ds1000-jp.census.trendmicro.com" "ds1000-sc.census.trendmicro.com" "ds1000-tc.census.trendmicro.com"
"deepsec12-en.gfrbridge.trendmicro.com" "deepsec12-jp.gfrbridge.trendmicro.com" "deepsec11-en.gfrbridge.trendmicro.com" "deepsec11-jp.gfrbridge.trendmicro.com" "deepsec102-en.gfrbridge.trendmicro.com"
"deepsec102-jp.gfrbridge.trendmicro.com" "deepsec10-en.grid-gfr.trendmicro.com" "deepsec10-jp.grid-gfr.trendmicro.com" "deepsec10-cn.grid-gfr.trendmicro.com" "ds120.icrc.trendmicro.com" "ds120-jp.icrc.trendmicro.com"
"ds110.icrc.trendmicro.com" "ds110-jp.icrc.trendmicro.com" "ds102.icrc.trendmicro.com" "ds102-jp.icrc.trendmicro.com" "ds102-sc.icrc.trendmicro.com.cn" "ds10.icrc.trendmicro.com" "ds10-jp.icrc.trendmicro.com"
"ds10-sc.icrc.trendmicro.com" "iaufdbk.trendmicro.com" "ds96.icrc.trendmicro.com" "ds96-jp.icrc.trendmicro.com" "ds96-sc.icrc.trendmicro.com.cn" "ds95.icrc.trendmicro.com" "ds95-jp.icrc.trendmicro.com"
"ds95-sc.icrc.trendmicro.com.cn" "ds120-en-b.trx.trendmicro.com" "ds120-jp-b.trx.trendmicro.com" "ds120-en-f.trx.trendmicro.com" "ds120-jp-f.trx.trendmicro.com" "ds110-en-b.trx.trendmicro.com"
"ds110-jp-b.trx.trendmicro.com" "ds110-en-f.trx.trendmicro.com" "ds110-jp-f.trx.trendmicro.com" "ds102-en-f.trx.trendmicro.com" "ds102-jp-f.trx.trendmicro.com" "ds102-sc-f.trx.trendmicro.com"
"ds12-0-en.url.trendmicro.com" "ds12-0-jp.url.trendmicro.com" "ds11-0-en.url.trendmicro.com" "ds11-0-jp.url.trendmicro.com" "ds10-2-en.url.trendmicro.com" "ds10-2-sc.url.trendmicro.com.cn"
"ds10-2-jp.url.trendmicro.com" "ds100-en.url.trendmicro.com" "ds100-sc.url.trendmicro.com" "ds100-jp.url.trendmicro.com" "ds96-en.url.trendmicro.com" "ds96-jp.url.trendmicro.com"
"ds95-en.url.trendmicro.com" "ds95-jp.url.trendmicro.com" "sitesafety.trendmicro.com" "jp.sitesafety.trendmicro.com" "iaus.activeupdate.trendmicro.com" "iaus.trendmicro.com" "ipv6-iaus.trendmicro.com"
"ipv6-iaus.activeupdate.trendmicro.com")

#Functions
ShowMenu (){
echo "Deep Security Agent Pre-Check Tool"
echo "Choose option and press Enter."
echo "1: Press '1' for DSaaS pre-check."
echo "2: Press '2' for Deep Security AMI pre-check."
echo "3: Press '3' for Deep Security On-Premise pre-check."
echo "4: Press '4' to Check specific IP/URL and port connectivity"
echo "Q: Press 'q' to quit."
}

DSaaSChecker (){
			Dagents=$(nc -z -v -w 2 $DSaaS1 $DSaaSPort &> /dev/null && echo "Online" || echo "Offline")
			if [[ $Dagents == "Online" ]]; then
			        echo -e "Successfully connected to $DSaaS1 via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSaaS1 via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
			fi

			Dapp=$(nc -z -v -w 2 $DSaaS2 $DSaaSPort &> /dev/null && echo "Online" || echo "Offline")
			if [[ $Dapp == "Online" ]]; then
			        echo -e "Successfully connected to $DSaaS2 via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSaaS2 via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
			fi

			Drelay=$(nc -z -v -w 2 $DSaaS3 $DSaaSPort &> /dev/null && echo "Online" || echo "Offline")
			if [[ $Drelay == "Online" ]]; then
			        echo -e "Successfully connected to $DSaaS3 via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSaaS3 via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
			fi

			Ddsmim=$(nc -z -v -w 2 $DSaaS4 $DSaaSPort &> /dev/null && echo "Online" || echo "Offline")
			if [[ $Ddsmim == "Online" ]]; then
			        echo -e "Successfully connected to $DSaaS4 via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSaaS4 via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
			fi

			for DSaaSURL in "${DSaaSURLs[@]}"
			do
				DSaaSlist=$(nc -z -v -w 2 $DSaaSURL $DSaaSPort &> /dev/null && echo "Online" || echo "Offline")
				if [[ $DSaaSlist == "Online" ]]; then
				        echo -e "Successfully connected to $DSaaSURL via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
				else
				        echo -e "Failed to connect to $DSaaSURL via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
				fi
			done

			for DSaaSURL in "${DSaaSURLs[@]}"
			do
				DSaaSlist=$(nc -z -v -w 2 $DSaaSURL $DSaaSPort80 &> /dev/null && echo "Online" || echo "Offline")
				if [[ $DSaaSlist == "Online" ]]; then
				        echo -e "Successfully connected to $DSaaSURL via TCP port $DSaaSPort80" >> /tmp/DSaaS_Pre-check/connection.txt
				else
				        echo -e "Failed to connect to $DSaaSURL via TCP port $DSaaSPor80" >> /tmp/DSaaS_Pre-check/connection.txt
				fi
			done

			#Check TLS/SSL Connection to DSaaS
			echo "Checking SSL/TLS Connection to the URLs..."

			if [[ $(curl -m 5 -v https://$DSaaS1 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSaaS1:$DSaaSPort via TLS/SSL\n" >> /tmp/DSaaS_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSaaS1 >> /tmp/DSaaS_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSaaS1:$DSaaSPort via TLS/SSL" >> /tmp/DSaaS_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSaaS2 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSaaS2:$DSaaSPort via TLS/SSL\n" >> /tmp/DSaaS_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSaaS2 >> /tmp/DSaaS_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSaaS2:$DSaaSPort via TLS/SSL" >> /tmp/DSaaS_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSaaS3 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSaaS3:$DSaaSPort via TLS/SSL\n" >> /tmp/DSaaS_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSaaS3 >> /tmp/DSaaS_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSaaS3:$DSaaSPort via TLS/SSL" >> /tmp/DSaaS_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSaaS4 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSaaS4:$DSaaSPort via TLS/SSL\n" >> /tmp/DSaaS_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSaaS4 >> /tmp/DSaaS_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSaaS4:$DSaaSPort via TLS/SSL" >> /tmp/DSaaS_Pre-check/connection.txt
			fi

			#Check Listening Ports
			echo "Checking Listening and Established Ports..."
			echo -e "\nChecking Listening and Established Ports...\n" >> /tmp/DSaaS_Pre-check/connection.txt
			
			sudo lsof -i -P -n | grep -e "LISTEN" -e "ESTABLISHED" >> /tmp/DSaaS_Pre-check/connection.txt
}

DSaaSChecker-2 (){
			Dagents=$(nc -z -v -w 2 $DSaaS1 $DSaaSPort &> /dev/null && echo "Online" || echo "Offline")
			if [[ $Dagents == "Online" ]]; then
			        echo -e "Successfully connected to $DSaaS1 via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSaaS1 via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
			fi

			Dapp=$(nc -z -v -w 2 $DSaaS2 $DSaaSPort &> /dev/null && echo "Online" || echo "Offline")
			if [[ $Dapp == "Online" ]]; then
			        echo -e "Successfully connected to $DSaaS2 via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSaaS2 via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
			fi

			Drelay=$(nc -z -v -w 2 $DSaaS3 $DSaaSPort &> /dev/null && echo "Online" || echo "Offline")
			if [[ $Drelay == "Online" ]]; then
			        echo -e "Successfully connected to $DSaaS3 via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSaaS3 via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
			fi

			Ddsmim=$(nc -z -v -w 2 $DSaaS4 $DSaaSPort &> /dev/null && echo "Online" || echo "Offline")
			if [[ $Ddsmim == "Online" ]]; then
			        echo -e "Successfully connected to $DSaaS4 via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSaaS4 via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
			fi
			for DSaaSURL in "${DSaaSURLs[@]}"
			do
				DSaaSlist=$(nc -z -v -w 2 $DSaaSURL $DSaaSPort &> /dev/null && echo "Online" || echo "Offline")
				if [[ $DSaaSlist == "Online" ]]; then
				        echo -e "Successfully connected to $DSaaSURL via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
				else
				        echo -e "Failed to connect to $DSaaSURL via TCP port $DSaaSPort" >> /tmp/DSaaS_Pre-check/connection.txt
				fi
			done

			for DSaaSURL in "${DSaaSURLs[@]}"
			do
				DSaaSlist=$(nc -z -v -w 2 $DSaaSURL $DSaaSPort80 &> /dev/null && echo "Online" || echo "Offline")
				if [[ $DSaaSlist == "Online" ]]; then
				        echo -e "Successfully connected to $DSaaSURL via TCP port $DSaaSPort80" >> /tmp/DSaaS_Pre-check/connection.txt
				else
				        echo -e "Failed to connect to $DSaaSURL via TCP port $DSaaSPort80" >> /tmp/DSaaS_Pre-check/connection.txt
				fi
			done

			#Check TLS/SSL Connection to DSaaS
			echo "Checking SSL/TLS Connection to the URLs..."

			if [[ $(curl -m 5 -v https://$DSaaS1 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSaaS1:$DSaaSPort via TLS/SSL\n" >> /tmp/DSaaS_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSaaS1 >> /tmp/DSaaS_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSaaS1:$DSaaSPort via TLS/SSL" >> /tmp/DSaaS_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSaaS2 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSaaS2:$DSaaSPort via TLS/SSL\n" >> /tmp/DSaaS_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSaaS2 >> /tmp/DSaaS_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSaaS2:$DSaaSPort via TLS/SSL" >> /tmp/DSaaS_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSaaS3 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSaaS3:$DSaaSPort via TLS/SSL\n" >> /tmp/DSaaS_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSaaS3 >> /tmp/DSaaS_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSaaS3:$DSaaSPort via TLS/SSL" >> /tmp/DSaaS_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSaaS4 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSaaS4:$DSaaSPort via TLS/SSL\n" >> /tmp/DSaaS_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSaaS4 >> /tmp/DSaaS_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSaaS4:$DSaaSPort via TLS/SSL" >> /tmp/DSaaS_Pre-check/connection.txt
			fi

			#Check Listening Ports
			echo "Checking Listening and Established Ports..."
			echo -e "\nChecking Listening and Established Ports...\n" >> /tmp/DSaaS_Pre-check/connection.txt
			
			sudo lsof -i -P -n | grep -e "LISTEN" -e "ESTABLISHED" >> /tmp/DSaaS_Pre-check/connection.txt
}

DSAMIChecker () {
			DS443=$(nc -z -v -w 2 $DSAMIURL $DSAMI443 &> /dev/null && echo "Online" || echo "Offline")
			if [[ $DS443 == "Online" ]]; then
			        echo -e "Successfully connected to $DSAMIURL via TCP port $DSAMI443" > /tmp/DSAMI_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSAMIURL via TCP port $DSAMI443" > /tmp/DSAMI_Pre-check/connection.txt
			fi

			DS4120=$(nc -z -v -w 2 $DSAMIURL $DSAMI4120 &> /dev/null && echo "Online" || echo "Offline")
			if [[ $DS4120 == "Online" ]]; then
			        echo -e "Successfully connected to $DSAMIURL via TCP port $DSAMI4120" >> /tmp/DSAMI_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSAMIURL via TCP port $DSAMI4120" >> /tmp/DSAMI_Pre-check/connection.txt
			fi

			DS4122=$(nc -z -v -w 2 $DSAMIURL $DSAMI4122 &> /dev/null && echo "Online" || echo "Offline")
			if [[ $DS4122 == "Online" ]]; then
			        echo -e "Successfully connected to $DSAMIURL via TCP port $DSAMI4122" >> /tmp/DSAMI_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSAMIURL via TCP port $DSAMI4122" >> /tmp/DSAMI_Pre-check/connection.txt
			fi
			for DSAMIandONPURL in "${DSAMIandONPURLs[@]}"
			do
				DSAMIONPlist=$(nc -z -v -w 2 $DSAMIandONPURL $DSAMI443 &> /dev/null && echo "Online" || echo "Offline")
				if [[ $DSAMIONPlist == "Online" ]]; then
				        echo -e "Successfully connected to $DSAMIandONPURL via TCP port $DSAMI443" >> /tmp/DSAMI_Pre-check/connection.txt
				else
				        echo -e "Failed to connect to $DSAMIandONPURL via TCP port $DSAMI443" >> /tmp/DSAMI_Pre-check/connection.txt
				fi
			done

			for DSAMIandONPURL in "${DSAMIandONPURLs[@]}"
			do
				DSAMIONPlist=$(nc -z -v -w 2 $DSAMIandONPURL $DSAMI80 &> /dev/null && echo "Online" || echo "Offline")
				if [[ $DSAMIONPlist == "Online" ]]; then
				        echo -e "Successfully connected to $DSAMIandONPURL via TCP port $DSAMI80" >> /tmp/DSAMI_Pre-check/connection.txt
				else
				        echo -e "Failed to connect to $DSAMIandONPURL via TCP port $DSAMI80" >> /tmp/DSAMI_Pre-check/connection.txt
				fi
			done

			#Check TLS/SSL Connection to DSAMI
			echo "Checking SSL/TLS Connection to the URLs..."

			if [[ $(curl -m 5 -v https://$DSAMIURL:$DSAMI443 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSAMIURL:$DSAMI443 via TLS/SSL\n" >> /tmp/DSAMI_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSAMIURL:$DSAMI443 >> /tmp/DSAMI_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSAMIURL:$DSAMI443 via TLS/SSL" >> /tmp/DSAMI_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSAMIURL:$DSAMI4118 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSAMIURL:$DSAMI4118 via TLS/SSL\n" >> /tmp/DSAMI_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSAMIURL:$DSAMI4118 >> /tmp/DSAMI_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSAMIURL:$DSAMI4118 via TLS/SSL" >> /tmp/DSAMI_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSAMIURL:$DSAMI4120 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSAMIURL:$DSAMI4120 via TLS/SSL\n" >> /tmp/DSAMI_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSAMIURL:$DSAMI4120 >> /tmp/DSAMI_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSAMIURL:$DSAMI4120 via TLS/SSL" >> /tmp/DSAMI_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSAMIURL:$DSAMI4122 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSAMIURL:$DSAMI4122 via TLS/SSL\n" >> /tmp/DSAMI_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSAMIURL:$DSAMI4122 >> /tmp/DSAMI_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSAMIURL:$DSAMI4122 via TLS/SSL" >> /tmp/DSAMI_Pre-check/connection.txt
			fi

			#Check Listening Ports
			echo "Checking Listening and Established Ports..."
			echo -e "\nChecking Listening and Established Ports...\n" >> /tmp/DSAMI_Pre-check/connection.txt
			
			sudo lsof -i -P -n | grep -e "LISTEN" -e "ESTABLISHED" >> /tmp/DSAMI_Pre-check/connection.txt
}

DSAMIChecker-2 () {
			DS443=$(nc -z -v -w 2 $DSAMIURL $DSAMI443 &> /dev/null && echo "Online" || echo "Offline")
			if [[ $DS443 == "Online" ]]; then
			        echo -e "Successfully connected to $DSAMIURL via TCP port $DSAMI443" >> /tmp/DSAMI_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSAMIURL via TCP port $DSAMI443" >> /tmp/DSAMI_Pre-check/connection.txt
			fi

			DS4120=$(nc -z -v -w 2 $DSAMIURL $DSAMI4120 &> /dev/null && echo "Online" || echo "Offline")
			if [[ $DS4120 == "Online" ]]; then
			        echo -e "Successfully connected to $DSAMIURL via TCP port $DSAMI4120" >> /tmp/DSAMI_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSAMIURL via TCP port $DSAMI4120" >> /tmp/DSAMI_Pre-check/connection.txt
			fi

			DS4122=$(nc -z -v -w 2 $DSAMIURL $DSAMI4122 &> /dev/null && echo "Online" || echo "Offline")
			if [[ $DS4122 == "Online" ]]; then
			        echo -e "Successfully connected to $DSAMIURL via TCP port $DSAMI4122" >> /tmp/DSAMI_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSAMIURL via TCP port $DSAMI4122" >> /tmp/DSAMI_Pre-check/connection.txt
			fi
			for DSAMIandONPURL in "${DSAMIandONPURLs[@]}"
			do
				DSAMIONPlist=$(nc -z -v -w 2 $DSAMIandONPURL $DSAMI443 &> /dev/null && echo "Online" || echo "Offline")
				if [[ $DSAMIONPlist == "Online" ]]; then
				        echo -e "Successfully connected to $DSAMIandONPURL via TCP port $DSAMI443" >> /tmp/DSAMI_Pre-check/connection.txt
				else
				        echo -e "Failed to connect to $DSAMIandONPURL via TCP port $DSAMI443" >> /tmp/DSAMI_Pre-check/connection.txt
				fi
			done

			for DSAMIandONPURL in "${DSAMIandONPURLs[@]}"
			do
				DSAMIONPlist=$(nc -z -v -w 2 $DSAMIandONPURL $DSAMI80 &> /dev/null && echo "Online" || echo "Offline")
				if [[ $DSAMIONPlist == "Online" ]]; then
				        echo -e "Successfully connected to $DSAMIandONPURL via TCP port $DSAMI80" >> /tmp/DSAMI_Pre-check/connection.txt
				else
				        echo -e "Failed to connect to $DSAMIandONPURL via TCP port $DSAMI80" >> /tmp/DSAMI_Pre-check/connection.txt
				fi
			done

			#Check TLS/SSL Connection to DSAMI
			echo "Checking SSL/TLS Connection to the URLs..."

			if [[ $(curl -m 5 -v https://$DSAMIURL:$DSAMI443 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSAMIURL:$DSAMI443 via TLS/SSL\n" >> /tmp/DSAMI_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSAMIURL:$DSAMI443 >> /tmp/DSAMI_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSAMIURL:$DSAMI443 via TLS/SSL" >> /tmp/DSAMI_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSAMIURL:$DSAMI4118 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSAMIURL:$DSAMI4118 via TLS/SSL\n" >> /tmp/DSAMI_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSAMIURL:$DSAMI4118 >> /tmp/DSAMI_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSAMIURL:$DSAMI4118 via TLS/SSL" >> /tmp/DSAMI_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSAMIURL:$DSAMI4120 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSAMIURL:$DSAMI4120 via TLS/SSL\n" >> /tmp/DSAMI_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSAMIURL:$DSAMI4120 >> /tmp/DSAMI_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSAMIURL:$DSAMI4120 via TLS/SSL" >> /tmp/DSAMI_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSAMIURL:$DSAMI4122 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSAMIURL:$DSAMI4122 via TLS/SSL\n" >> /tmp/DSAMI_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSAMIURL:$DSAMI4122 >> /tmp/DSAMI_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSAMIURL:$DSAMI4122 via TLS/SSL" >> /tmp/DSAMI_Pre-check/connection.txt
			fi

			#Check Listening Ports
			echo "Checking Listening and Established Ports..."
			echo -e "\nChecking Listening and Established Ports...\n" >> /tmp/DSAMI_Pre-check/connection.txt
			
			sudo lsof -i -P -n | grep -e "LISTEN" -e "ESTABLISHED" >> /tmp/DSAMI_Pre-check/connection.txt
}

DSONPChecker (){
			DSO4119=$(nc -z -v -w 2 $DSONPURL $DSONP4119 &> /dev/null && echo "Online" || echo "Offline")
			if [[ $DSO4119 == "Online" ]]; then
			        echo -e "Successfully connected to $DSONPURL via TCP port $DSONP4119" > /tmp/DSONP_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSONPURL via TCP port $DSONP4119" > /tmp/DSONP_Pre-check/connection.txt
			fi

			DSO4120=$(nc -z -v -w 2 $DSONPURL $DSONP4120 &> /dev/null && echo "Online" || echo "Offline")
			if [[ $DSO4120 == "Online" ]]; then
			        echo -e "Successfully connected to $DSONPURL via TCP port $DSONP4120" >> /tmp/DSONP_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSONPURL via TCP port $DSONP4120" >> /tmp/DSONP_Pre-check/connection.txt
			fi

			DSO4122=$(nc -z -v -w 2 $DSONPURL $DSONP4122 &> /dev/null && echo "Online" || echo "Offline")
			if [[ $DSO4122 == "Online" ]]; then
			        echo -e "Successfully connected to $DSONPURL via TCP port $DSONP4122" >> /tmp/DSONP_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSONPURL via TCP port $DSONP4122" >> /tmp/DSONP_Pre-check/connection.txt
			fi

			for DSAMIandONPURL in "${DSAMIandONPURLs[@]}"
			do
				DSAMIONPlist=$(nc -z -v -w 2 $DSAMIandONPURL $DSONP443 &> /dev/null && echo "Online" || echo "Offline")
				if [[ $DSAMIONPlist == "Online" ]]; then
				        echo -e "Successfully connected to $DSAMIandONPURL via TCP port $DSONP443" >> /tmp/DSONP_Pre-check/connection.txt
				else
				        echo -e "Failed to connect to $DSAMIandONPURL via TCP port $DSONP443" >> /tmp/DSONP_Pre-check/connection.txt
				fi
			done

			for DSAMIandONPURL in "${DSAMIandONPURLs[@]}"
			do
				DSAMIONPlist=$(nc -z -v -w 2 $DSAMIandONPURL $DSONP80 &> /dev/null && echo "Online" || echo "Offline")
				if [[ $DSAMIONPlist == "Online" ]]; then
				        echo -e "Successfully connected to $DSAMIandONPURL via TCP port $DSONP80" >> /tmp/DSONP_Pre-check/connection.txt
				else
				        echo -e "Failed to connect to $DSAMIandONPURL via TCP port $DSONP80" >> /tmp/DSONP_Pre-check/connection.txt
				fi
			done

			#Check TLS/SSL Connection to DSONP
			echo "Checking SSL/TLS Connection to the URLs..."

			if [[ $(curl -m 5 -v https://$DSONPURL:$DSONP4118 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSONPURL:$DSONP4118 via TLS/SSL\n" >> /tmp/DSONP_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSONPURL:$DSONP4118 >> /tmp/DSONP_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSONPURL:$DSONP4118 via TLS/SSL" >> /tmp/DSONP_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSONPURL:$DSONP4119 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSONPURL:$DSONP4119 via TLS/SSL\n" >> /tmp/DSONP_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSONPURL:$DSONP4119 >> /tmp/DSONP_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSONPURL:$DSONP4119 via TLS/SSL" >> /tmp/DSONP_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSONPURL:$DSONP4120 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSONPURL:$DSONP4120 via TLS/SSL\n" >> /tmp/DSONP_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSONPURL:$DSONP4120 >> /tmp/DSONP_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSONPURL:$DSONP4120 via TLS/SSL" >> /tmp/DSONP_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSONPURL:$DSONP4122 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSONPURL:$DSONP4122 via TLS/SSL\n" >> /tmp/DSONP_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSONPURL:$DSONP4122 >> /tmp/DSONP_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSONPURL:$DSONP4122 via TLS/SSL" >> /tmp/DSONP_Pre-check/connection.txt
			fi

			#Check Listening Ports
			echo "Checking Listening and Established Ports..."
			echo -e "\nChecking Listening and Established Ports...\n" >> /tmp/DSONP_Pre-check/connection.txt
			
			sudo lsof -i -P -n | grep -e "LISTEN" -e "ESTABLISHED" >> /tmp/DSONP_Pre-check/connection.txt

}

DSONPChecker-2 (){
			DSO4119=$(nc -z -v -w 2 $DSONPURL $DSONP4119 &> /dev/null && echo "Online" || echo "Offline")
			if [[ $DSO4119 == "Online" ]]; then
			        echo -e "Successfully connected to $DSONPURL via TCP port $DSONP4119" >> /tmp/DSONP_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSONPURL via TCP port $DSONP4119" >> /tmp/DSONP_Pre-check/connection.txt
			fi

			DSO4120=$(nc -z -v -w 2 $DSONPURL $DSONP4120 &> /dev/null && echo "Online" || echo "Offline")
			if [[ $DSO4120 == "Online" ]]; then
			        echo -e "Successfully connected to $DSONPURL via TCP port $DSONP4120" >> /tmp/DSONP_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSONPURL via TCP port $DSONP4120" >> /tmp/DSONP_Pre-check/connection.txt
			fi

			DSO4122=$(nc -z -v -w 2 $DSONPURL $DSONP4122 &> /dev/null && echo "Online" || echo "Offline")
			if [[ $DSO4122 == "Online" ]]; then
			        echo -e "Successfully connected to $DSONPURL via TCP port $DSONP4122" >> /tmp/DSONP_Pre-check/connection.txt
			else
			        echo -e "Failed to connect to $DSONPURL via TCP port $DSONP4122" >> /tmp/DSONP_Pre-check/connection.txt
			fi

			for DSAMIandONPURL in "${DSAMIandONPURLs[@]}"
			do
				DSAMIONPlist=$(nc -z -v -w 2 $DSAMIandONPURL $DSONP443 &> /dev/null && echo "Online" || echo "Offline")
				if [[ $DSAMIONPlist == "Online" ]]; then
				        echo -e "Successfully connected to $DSAMIandONPURL via TCP port $DSONP443" >> /tmp/DSONP_Pre-check/connection.txt
				else
				        echo -e "Failed to connect to $DSAMIandONPURL via TCP port $DSONP443" >> /tmp/DSONP_Pre-check/connection.txt
				fi
			done

			for DSAMIandONPURL in "${DSAMIandONPURLs[@]}"
			do
				DSAMIONPlist=$(nc -z -v -w 2 $DSAMIandONPURL $DSONP80 &> /dev/null && echo "Online" || echo "Offline")
				if [[ $DSAMIONPlist == "Online" ]]; then
				        echo -e "Successfully connected to $DSAMIandONPURL via TCP port $DSONP80" >> /tmp/DSONP_Pre-check/connection.txt
				else
				        echo -e "Failed to connect to $DSAMIandONPURL via TCP port $DSONP80" >> /tmp/DSONP_Pre-check/connection.txt
				fi
			done

			#Check TLS/SSL Connection to DSONP
			echo "Checking SSL/TLS Connection to the URLs..."

			if [[ $(curl -m 5 -v https://$DSONPURL:$DSONP4118 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSONPURL:$DSONP4118 via TLS/SSL\n" >> /tmp/DSONP_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSONPURL:$DSONP4118 >> /tmp/DSONP_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSONPURL:$DSONP4118 via TLS/SSL" >> /tmp/DSONP_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSONPURL:$DSONP4119 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSONPURL:$DSONP4119 via TLS/SSL\n" >> /tmp/DSONP_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSONPURL:$DSONP4119 >> /tmp/DSONP_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSONPURL:$DSONP4119 via TLS/SSL" >> /tmp/DSONP_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSONPURL:$DSONP4120 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSONPURL:$DSONP4120 via TLS/SSL\n" >> /tmp/DSONP_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSONPURL:$DSONP4120 >> /tmp/DSONP_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSONPURL:$DSONP4120 via TLS/SSL" >> /tmp/DSONP_Pre-check/connection.txt
			fi

			if [[ $(curl -m 5 -v https://$DSONPURL:$DSONP4122 2>&1 |  grep "Connected") ]]; then
			        echo -e "\nSuccessfully connected to $DSONPURL:$DSONP4122 via TLS/SSL\n" >> /tmp/DSONP_Pre-check/connection.txt
			        curl -m 5 -vs https://$DSONPURL:$DSONP4122 >> /tmp/DSONP_Pre-check/connection.txt 2>&1
			else
			        echo -e "Failed to connect to $DSONPURL:$DSONP4122 via TLS/SSL" >> /tmp/DSONP_Pre-check/connection.txt
			fi

			#Check Listening Ports
			echo "Checking Listening and Established Ports..."
			echo -e "\nChecking Listening and Established Ports...\n" >> /tmp/DSONP_Pre-check/connection.txt
			
			sudo lsof -i -P -n | grep -e "LISTEN" -e "ESTABLISHED" >> /tmp/DSONP_Pre-check/connection.txt

}

#Main Program
until [[ $input == 'q' ]]
do
	ShowMenu
	read input
	case $input in  
		1)
			echo "Option 1 - DSaaS"

			#Variables
			sudo mkdir /tmp/DSaaS_Pre-check/
			DSaaSPort80=80
			DSaaSPort=443
			DSaaS1=agents.deepsecurity.trendmicro.com
			DSaaS2=app.deepsecurity.trendmicro.com
			DSaaS3=relay.deepsecurity.trendmicro.com
			DSaaS4=dsmim.deepsecurity.trendmicro.com

			#Check Proxy
			proxy=$(env | grep -i proxy)
			sudoproxy=$(sudo env | grep -i proxy)
			if [[ $proxy != '' ]]; then
				echo -e "This machine has a proxy enabled.\n" > /tmp/DSaaS_Pre-check/connection.txt
				echo $proxy >> /tmp/DSaaS_Pre-check/connection.txt
				echo "This machine has a proxy enabled."
			elif [[ $sudoproxy != '' ]]; then
				echo -e "(sudo) This machine has a proxy enabled.\n" > /tmp/DSaaS_Pre-check/connection.txt
				echo $sudoproxy >> /tmp/DSaaS_Pre-check/connection.txt
				echo "(sudo) This machine has a proxy enabled."
			else
				echo "This machine has no proxy enabled." > /tmp/DSaaS_Pre-check/connection.txt
				echo "This machine has no proxy enabled."
			fi

			#Check TCP connection to DSaaS
			echo "Checking connection to the URLs of Deep Security As A Service..."
			DSaaSChecker
			echo "Done. See connection.txt inside the zip file that will be created later for more information."

			#Test to send heartbeat to the Manager

			echo "Sending Heartbeat to the Manager..."
			if [[ $(sudo /opt/ds_agent/dsa_control -m |  grep "next few seconds") ]]; then
			        echo -e "\nHTTP Status: 200 - OK\nResponse:\nManager contact has been scheduled to occur in the next few seconds.\n" >> /tmp/DSaaS_Pre-check/connection.txt
			        echo "Successfully sent out a heartbeat to the Manager."
			        #Check if debugging will be enabled or not
					ainput=''
					until [[ $ainput == 'y' || $ainput == 'n' ]]
					do
						echo "Enable agent debugging?(if agent is not installed, choose n)(y/n):"
						read ainput
						if [[ $ainput == 'y' ]]; then
							echo "Enabling agent debugging..."
							echo -e "Enabling agent debugging...\n" >> /tmp/DSaaS_Pre-check/connection.txt
							sudo /opt/ds_agent/sendCommand --get Trace?trace=* >> /tmp/DSaaS_Pre-check/connection.txt
							echo -e "\nAgent debugging enabled.\n" >> /tmp/DSaaS_Pre-check/connection.txt
							echo "Agent debugging enabled."
							echo "Rechecking Connection to URLs. Please wait..."
							DSaaSChecker-2
							echo "Rechecking Connection Done."
							echo "Replicate the issue. Press y and Enter once done:"
							read binput
							if [[ $binput == 'y' ]]; then
								sudo service ds_agent restart
								if [[ $(sudo service ds_agent status | grep "running") ]]; then
									echo -e "\nService has been restarted successfully\n" >> /tmp/DSaaS_Pre-check/connection.txt
									echo "Service has been restarted successfully."
								else
									echo -e "\nService failed to restart.\n" >> /tmp/DSaaS_Pre-check/connection.txt
									echo "Service failed to restart."
								fi
							fi
							echo -e "Creating Diagnostic Package..." >> /tmp/DSaaS_Pre-check/connection.txt
							echo "Creating Diagnostic Package..."
							sleep 5s
							if [[ $(sudo /opt/ds_agent/dsa_control -d |  grep "diagnostic package done") ]]; then
								while [ -f /var/opt/ds_agent/diag/*.tmp ];
								do
									sleep 5s
								done
								sleep 5s
								latest_diag=$(ls -1t /var/opt/ds_agent/diag | head -2 | grep .zip)
								sudo mv /var/opt/ds_agent/diag/$latest_diag /tmp/DSaaS_Pre-check/
								echo -e "Creating Diagnostic Package...Done\n" >> /tmp/DSaaS_Pre-check/connection.txt
								echo "Creating Diagnostic Package...Done"
							fi
						elif [[ $ainput == 'n' ]]; then
							echo -e "Creating Diagnostic Package...\n" >> /tmp/DSaaS_Pre-check/connection.txt
							echo "Creating Diagnostic Package..."
							if [[ $(sudo /opt/ds_agent/dsa_control -d |  grep "diagnostic package done") ]]; then
								while [ -f /var/opt/ds_agent/diag/*.tmp ];
								do
									sleep 5s
								done
								sleep 5s
								latest_diag=$(ls -1t /var/opt/ds_agent/diag | head -2 | grep .zip)
								sudo cp /var/opt/ds_agent/diag/$latest_diag /tmp/DSaaS_Pre-check/
								echo -e "Creating Diagnostic Package...Done\n" >> /tmp/DSaaS_Pre-check/connection.txt
								echo "Creating Diagnostic Package...Done"
							fi
						fi
					done
			else
			        echo -e "\nFailed to send a heartbeat to the Manager. Check if agent is installed properly.\n" >> /tmp/DSaaS_Pre-check/connection.txt
			        echo "Failed to send a heartbeat to the Manager. Check if agent is installed properly."

			        cp /proc/cpuinfo /tmp/DSaaS_Pre-check/cpuinfo
			        cp /proc/meminfo /tmp/DSaaS_Pre-check/meminfo
			        df -a > /tmp/DSaaS_Pre-check/diskinfo.txt
			fi

			sleep 3s
			echo -e "Getting all running task...\n" >> /tmp/DSaaS_Pre-check/connection.txt
			echo "Getting all running task..."
			top -n 1 2>&1 >> /tmp/DSaaS_Pre-check/connection.txt
			echo -e "\nGetting all running task...Done" >> /tmp/DSaaS_Pre-check/connection.txt
			echo "Getting all running task...Done"
			sleep 3s
			latest_diag2=$(ls -1t /tmp/DSaaS_Pre-check | head -2 | grep .zip)
			sudo cp /tmp/DSaaS_Pre-check/$latest_diag2 $latest_diag2
			sudo zip -r DSaaS_Pre-check.zip /tmp/DSaaS_Pre-check/
			echo "Successfully Created ZIP file in the same directory of the script."
			sudo rm -rf /tmp/DSaaS_Pre-check/
			echo ""
			;;
		2)
			echo "Option 2 - Deep Security AMI"

			#Variables
			sudo mkdir /tmp/DSAMI_Pre-check/
			DSAMI80=80
			DSAMI443=443
			DSAMI4118=4118
			DSAMI4120=4120
			DSAMI4122=4122
			echo "Enter DSM AMI URL/IP (if URL, do not include http/https):"
			read DSAMIURL

			#Check Proxy
			proxy=$(env | grep -i proxy)
			sudoproxy=$(sudo env | grep -i proxy)
			if [[ $proxy != '' ]]; then
				echo -e "This machine has a proxy enabled.\n" > /tmp/DSAMI_Pre-check/connection.txt
				echo $proxy >> /tmp/DSAMI_Pre-check/connection.txt
				echo "This machine has a proxy enabled."
			elif [[ $sudoproxy != '' ]]; then
				echo -e "(sudo) This machine has a proxy enabled.\n" > /tmp/DSAMI_Pre-check/connection.txt
				echo $sudoproxy >> /tmp/DSAMI_Pre-check/connection.txt
				echo "(sudo) This machine has a proxy enabled."
			else
				echo "This machine has no proxy enabled." > /tmp/DSAMI_Pre-check/connection.txt
				echo "This machine has no proxy enabled."
			fi

			#Check TCP connection to DSAMI
			echo "Checking connection to the URLs of Deep Security AMI..."
			DSAMIChecker
			echo "Done. See connection.txt inside the zip file that will be created later for more information."
		

			#Test to send heartbeat to the Manager

			echo "Sending Heartbeat to the Manager..."
			if [[ $(sudo /opt/ds_agent/dsa_control -m |  grep "next few seconds") ]]; then
			        echo -e "\nHTTP Status: 200 - OK\nResponse:\nManager contact has been scheduled to occur in the next few seconds.\n" >> /tmp/DSAMI_Pre-check/connection.txt
			        echo "Successfully sent out a heartbeat to the Manager."
			        #Check if debugging will be enabled or not
					ainput=''
					until [[ $ainput == 'y' || $ainput == 'n' ]]
					do
						echo "Enable agent debugging?(if agent is not installed, choose n)(y/n):"
						read ainput
						if [[ $ainput == 'y' ]]; then
							echo "Enabling agent debugging..."
							echo -e "Enabling agent debugging...\n" >> /tmp/DSAMI_Pre-check/connection.txt
							sudo /opt/ds_agent/sendCommand --get Trace?trace=* >> /tmp/DSAMI_Pre-check/connection.txt
							echo -e "\nAgent debugging enabled." >> /tmp/DSAMI_Pre-check/connection.txt
							echo "Agent debugging enabled."
							echo "Rechecking Connection to URLs. Please wait..."
							DSAMIChecker-2
							echo "Rechecking Connection Done."
							echo "Replicate the issue. Press y and Enter once done:"
							read binput
							if [[ $binput == 'y' ]]; then
								sudo service ds_agent restart
								if [[ $(sudo service ds_agent status | grep "running") ]]; then
									echo -e "\nService has been restarted successfully\n" >>/tmp/DSAMI_Pre-check/connection.txt
									echo "Service has been restarted successfully."
								else
									echo -e "\nService failed to restart.\n" >> /tmp/DSAMI_Pre-check/connection.txt
									echo "Service failed to restart."
								fi
							fi
							echo -e "Creating Diagnostic Package..." >> /tmp/DSAMI_Pre-check/connection.txt
							echo "Creating Diagnostic Package..."
							sleep 5s
							if [[ $(sudo /opt/ds_agent/dsa_control -d |  grep "diagnostic package done") ]]; then
								while [ -f /var/opt/ds_agent/diag/*.tmp ];
								do
									sleep 5s
								done
								sleep 5s
								latest_diag=$(ls -1t /var/opt/ds_agent/diag | head -2 | grep .zip)
								sudo mv /var/opt/ds_agent/diag/$latest_diag /tmp/DSAMI_Pre-check/
								echo -e "Creating Diagnostic Package...Done\n" >> /tmp/DSAMI_Pre-check/connection.txt
								echo "Creating Diagnostic Package...Done"
							fi
						elif [[ $ainput == 'n' ]]; then
							echo -e "Creating Diagnostic Package..." >> /tmp/DSAMI_Pre-check/connection.txt
							echo "Creating Diagnostic Package..."
							if [[ $(sudo /opt/ds_agent/dsa_control -d |  grep "diagnostic package done") ]]; then
								while [ -f /var/opt/ds_agent/diag/*.tmp ];
								do
									sleep 5s
								done
								sleep 5s
								latest_diag=$(ls -1t /var/opt/ds_agent/diag | head -2 | grep .zip)
								sudo cp /var/opt/ds_agent/diag/$latest_diag /tmp/DSAMI_Pre-check/
								echo -e "Creating Diagnostic Package...Done\n" >> /tmp/DSAMI_Pre-check/connection.txt
								echo "Creating Diagnostic Package...Done"
							fi
						fi
					done
			else
			        echo -e "\nFailed to send a heartbeat to the Manager. Check if agent is installed properly.\n" >> /tmp/DSAMI_Pre-check/connection.txt
			        echo "Failed to send a heartbeat to the Manager. Check if agent is installed properly."

			        cp /proc/cpuinfo /tmp/DSAMI_Pre-check/cpuinfo
			        cp /proc/meminfo /tmp/DSAMI_Pre-check/meminfo
			        df -a > /tmp/DSAMI_Pre-check/diskinfo.txt
			fi

			sleep 3s
			echo -e "Getting all running task...\n" >> /tmp/DSAMI_Pre-check/connection.txt
			echo "Getting all running task..."
			top -n 1 2>&1 >> /tmp/DSAMI_Pre-check/connection.txt
			echo -e "\nGetting all running task...Done" >> /tmp/DSAMI_Pre-check/connection.txt
			echo "Getting all running task...Done"
			sleep 3s
			latest_diag2=$(ls -1t /tmp/DSAMI_Pre-check | head -2 | grep .zip)
			sudo cp /tmp/DSAMI_Pre-check/$latest_diag2 $latest_diag2
			sudo zip -r DSAMI_Pre-check.zip /tmp/DSAMI_Pre-check/
			echo "Successfully Created ZIP file in the same directory of the script."
			sudo rm -rf /tmp/DSAMI_Pre-check/
			echo ""
			;;
		3)
			echo "Option 3 - Deep Security On-Premise"

			#Variables
			sudo mkdir /tmp/DSONP_Pre-check/
			DSONP80=80
			DSONP443=443
			DSONP4118=4118
			DSONP4119=4119
			DSONP4120=4120
			DSONP4122=4122
			echo "Enter DSM AMI URL/IP (if URL, do not include http/https):"
			read DSONPURL

			#Check Proxy
			proxy=$(env | grep -i proxy)
			sudoproxy=$(sudo env | grep -i proxy)
			if [[ $proxy != '' ]]; then
				echo -e "This machine has a proxy enabled.\n" > /tmp/DSONP_Pre-check/connection.txt
				echo $proxy >> /tmp/DSONP_Pre-check/connection.txt
				echo "This machine has a proxy enabled."
			elif [[ $sudoproxy != '' ]]; then
				echo -e "(sudo) This machine has a proxy enabled.\n" > /tmp/DSONP_Pre-check/connection.txt
				echo $sudoproxy >> /tmp/DSONP_Pre-check/connection.txt
				echo "(sudo) This machine has a proxy enabled."
			else
				echo "This machine has no proxy enabled." > /tmp/DSONP_Pre-check/connection.txt
				echo "This machine has no proxy enabled."
			fi

			#Check TCP connection to DS On-Premise
			echo "Checking connection to the URLs of Deep Security On-Premise..."
			DSONPChecker
			echo "Done. See connection.txt inside the zip file that will be created later for more information."

			#Test to send heartbeat to the Manager

			echo "Sending Heartbeat to the Manager..."
			if [[ $(sudo /opt/ds_agent/dsa_control -m |  grep "next few seconds") ]]; then
			        echo -e "\nHTTP Status: 200 - OK\nResponse:\nManager contact has been scheduled to occur in the next few seconds.\n" >> /tmp/DSONP_Pre-check/connection.txt
			        echo "Successfully sent out a heartbeat to the Manager."
			        #Check if debugging will be enabled or not
					ainput=''
					until [[ $ainput == 'y' || $ainput == 'n' ]]
					do
						echo "Enable agent debugging?(if agent is not installed, choose n)(y/n):"
						read ainput
						if [[ $ainput == 'y' ]]; then
							echo "Enabling agent debugging..."
							echo -e "Enabling agent debugging...\n" >> /tmp/DSONP_Pre-check/connection.txt
							sudo /opt/ds_agent/sendCommand --get Trace?trace=* >> /tmp/DSONP_Pre-check/connection.txt
							echo -e "\nAgent debugging enabled." >> /tmp/DSONP_Pre-check/connection.txt
							echo "Agent debugging enabled."
							echo "Rechecking Connection to URLs. Please wait..."
							DSONPChecker-2
							echo "Rechecking Connection Done."
							echo "Replicate the issue. Press y and Enter once done:"
							read binput
							if [[ $binput == 'y' ]]; then
								sudo service ds_agent restart
								if [[ $(sudo service ds_agent status | grep "running") ]]; then
									echo -e "\nService has been restarted successfully\n" >>/tmp/DSONP_Pre-check/connection.txt
									echo "Service has been restarted successfully."
								else
									echo -e "\nService failed to restart.\n" >> /tmp/DSONP_Pre-check/connection.txt
									echo "Service failed to restart."
								fi
							fi
							echo -e "Creating Diagnostic Package..." >> /tmp/DSONP_Pre-check/connection.txt
							echo "Creating Diagnostic Package..."
							sleep 5s
							if [[ $(sudo /opt/ds_agent/dsa_control -d |  grep "diagnostic package done") ]]; then
								while [ -f /var/opt/ds_agent/diag/*.tmp ];
								do
									sleep 5s
								done
								sleep 5s
								latest_diag=$(ls -1t /var/opt/ds_agent/diag | head -2 | grep .zip)
								sudo mv /var/opt/ds_agent/diag/$latest_diag /tmp/DSONP_Pre-check/
								echo -e "Creating Diagnostic Package...Done\n" >> /tmp/DSONP_Pre-check/connection.txt
								echo "Creating Diagnostic Package...Done"
							fi
						elif [[ $ainput == 'n' ]]; then
							echo -e "Creating Diagnostic Package..." >> /tmp/DSONP_Pre-check/connection.txt
							echo "Creating Diagnostic Package..."
							if [[ $(sudo /opt/ds_agent/dsa_control -d |  grep "diagnostic package done") ]]; then
								while [ -f /var/opt/ds_agent/diag/*.tmp ];
								do
									sleep 5s
								done
								sleep 5s
								latest_diag=$(ls -1t /var/opt/ds_agent/diag | head -2 | grep .zip)
								sudo cp /var/opt/ds_agent/diag/$latest_diag /tmp/DSONP_Pre-check/
								echo -e "Creating Diagnostic Package...Done\n" >> /tmp/DSONP_Pre-check/connection.txt
								echo "Creating Diagnostic Package...Done"
							fi
						fi
					done
			else
			        echo -e "\nFailed to send a heartbeat to the Manager. Check if agent is installed properly.\n" >> /tmp/DSONP_Pre-check/connection.txt
			        echo "Failed to send a heartbeat to the Manager. Check if agent is installed properly."


			        cp /proc/cpuinfo /tmp/DSONP_Pre-check/cpuinfo
			        cp /proc/meminfo /tmp/DSONP_Pre-check/meminfo
			        df -a > /tmp/DSONP_Pre-check/diskinfo.txt
			fi

			sleep 3s
			echo -e "Getting all running task...\n" >> /tmp/DSONP_Pre-check/connection.txt
			echo "Getting all running task..."
			top -n 1 2>&1 >> /tmp/DSONP_Pre-check/connection.txt
			echo -e "\nGetting all running task...Done" >> /tmp/DSONP_Pre-check/connection.txt
			echo "Getting all running task...Done"
			sleep 3s
			latest_diag2=$(ls -1t /tmp/DSONP_Pre-check | head -2 | grep .zip)
			sudo cp /tmp/DSONP_Pre-check/$latest_diag2 $latest_diag2
			sudo zip -r DSONP_Pre-check.zip /tmp/DSONP_Pre-check/
			echo "Successfully Created ZIP file in the same directory of the script."
			sudo rm -rf /tmp/DSONP_Pre-check/
			echo ""
			;;
		4)
			echo "Option 4 - Check specific IP/URL and port connectivity"

			echo "Enter URL/IP (if URL, do not include http/https):"
			read RawURL

			echo "Enter Port:"
			read RawPort

			RawCheck=$(nc -z -v -w 2 $RawURL $RawPort &> /dev/null && echo "Online" || echo "Offline")
			if [[ $RawCheck == "Online" ]]; then
			        echo "Successfully connected to $RawURL via TCP port $RawPort"
			else
			        echo "Failed to connect to $RawURL via TCP port $RawPort"
			fi

			if [[ $(curl -m 5 -v https://$RawURL:$RawPort 2>&1 |  grep "Connected") ]]; then
			        echo "Successfully connected to $RawURL:$RawPort via TLS/SSL"
			else
			        echo "Failed to connect to $RawURL:$RawPort via TLS/SSL"
			fi
			echo ""
			;;
		q)	
			echo "Thank you for using the tool!"
			;;
	esac	
done