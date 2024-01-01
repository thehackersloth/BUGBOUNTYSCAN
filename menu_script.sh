#!/bin/bash
trap '' SIGINT
trap ''  SIGQUIT
trap '' SIGTSTP

# display message and pause
pause(){
	local m="$@"
	echo "$m"
	read -p "Press [Enter] key to continue..." key
}
echo "This menu can run the following scripts: Whois, NSLookup, NMAP, Firewalk, Harvester, Fierce, and Nikto."
echo ""
echo "It also creates output files for each script that is run."
echo ""
echo "This script creates folders on your desktop for the various scans."
echo ""
echo "When you enter the name of the client it creates the various script subfolders in the client folder."
echo ""
echo "Please enter the name of the client (no spaces)"
read client
echo ""
mkdir ~/Desktop/$client
mkdir ~/Desktop/$client/NMAP
mkdir ~/Desktop/$client/Harvester
mkdir ~/Desktop/$client/Fierce
mkdir ~/Desktop/$client/Nikto
mkdir ~/Desktop/$client/Whois
mkdir ~/Desktop/$client/NSLookup
mkdir ~/Desktop/$client/WPScan
mkdir ~/Desktop/$client/Metagoofil
mkdir ~/Desktop/$client/HackerTarget
cp ~/Desktop/targets.txt ~/Desktop/$client/targets.txt

currentDate=`date +%Y%m%d`
# set an
while :
do
	# show menu
	clear
	echo "-------------------------------------"
	echo "	  S C R I P T - M E N U"
	echo "-------------------------------------"
	echo "1. Run NMAP Script Treating All Hosts As Up (-Pn)"
	echo "2. Run NMAP Script As Usual"
	echo "3. Run NMAP Firewalk Script on Multiple Hosts"
	echo "4. Run NMAP Firewalk Script on Multiple Hosts with -Pn"
	echo "5. Run NMAP Firewalk Script on a single host"
	echo "6. Run WhoIs Lookup"
	echo "7. NSLookup (MX and DNS)"
	echo "8. Run The Harvester"
	echo "9. Run Fierce DNS Lookup"
	echo "10. Run Nikto Web Vulnerability Scan"
	echo "11. Run Joomla Vulnerability Scan"
	echo "12. Hydra Password Attack"
	echo "13. WordPress Vulnerability Scan"
	echo "14. All-in-One"
	echo "15. AIO for domains (NSLookup, WhoIs, Fierce, Harvester, Nikto)"
	echo "16. Metadata Extraction (Metagoofil)"
	echo "17. Exit"
	echo "-------------------------------------"
	read -r -p "Enter your choice [1-17] : " c
	# take action
	case $c in
		1) echo NMAP scanning started
		    echo -ne '#                         (1%)\r'
		    sleep 1
  		   `nmap -sM -Pn --append-output --host-timeout 30m -iL ~/Desktop/targets.txt > ~/Desktop/$client/NMAP/nmap_FIN_ACK_Pn.txt`
		    echo -ne '##########                (16%)\r'
		    sleep 1
   		   `nmap -sS -sV -O -Pn --append-output --host-timeout 30m -iL ~/Desktop/targets.txt > ~/Desktop/$client/NMAP/nmap_TCP_SYN_Pn.txt`
		    echo -ne '################          (52%)\r'
		    sleep 1
  		   `nmap -sF -Pn --append-output --host-timeout 30m -iL ~/Desktop/targets.txt > ~/Desktop/$client/NMAP/nmap_TCP_FIN_Pn.txt`
		    echo -ne '###################       (65%)\r'
		    sleep 1
  		   `nmap -sU -Pn --append-output --host-timeout 30m -iL ~/Desktop/targets.txt > ~/Desktop/$client/NMAP/nmap_UDP_Pn.txt`
		   echo ""
		   echo NMAP scanning completed
		   echo ""
		   read -rsp $'All done with NMAP Pn scan. Press enter to continue...\n';;
		2) echo NMAP scanning started
		    echo -ne '#                         (1%)\r'
		    sleep 1
  		   `nmap -sM --append-output --host-timeout 30m -iL ~/Desktop/targets.txt > ~/Desktop/$client/NMAP/nmap_FIN_ACK.txt`
		    echo -ne '#####                     (17%)\r'
		    sleep 1
   		   `nmap -sS -sV -O --append-output --host-timeout 30m -iL ~/Desktop/targets.txt > ~/Desktop/$client/NMAP/nmap_TCP_SYN.txt`
		    echo -ne '#############             (52%)\r'
		    sleep 1
  		   `nmap -sF --append-output --host-timeout 30m -iL ~/Desktop/targets.txt > ~/Desktop/$client/NMAP/nmap_TCP_FIN.txt`
		    echo -ne '##################        (70%)\r'
		    sleep 1
  		   `nmap -sU --append-output --host-timeout 30m -iL ~/Desktop/targets.txt > ~/Desktop/$client/NMAP/nmap_UDP.txt`
		    echo -ne '######################### (92%)\r'
		   echo ""
		   echo NMAP scanning completed
		   echo ""
		   read -rsp $'All done with NMAP scan. Press enter to continue...\n';;
		3) echo ""
		   echo Firewalk Scan Starting
		   echo ""
		   echo "IMPORTANT PLEASE READ!"
		   echo "In order for the Firewalk script to work you must"
		   echo "format your targets.txt file a specific way. Make"
		   echo "sure that your hosts are all on one line, and there"
		   echo "are no commas in between each host before you run Firewalk"
		   echo "(i.e. 10.1.1.1 10.2.2.2 10.3.3.3 dontgothere.com)"
		   echo ""
		   echo "Enter the name for the file output (no spaces)"
		   read file
		   echo -ne '#####                     (33%)\r'
		   sleep 1
		   mkdir ~/Desktop/$client/NMAP/Firewalk/
		   `nmap --append-output --script=firewalk --traceroute -iL ~/Desktop/targets.txt > ~/Desktop/$client/NMAP/Firewalk/firewalk_$currentDate.txt`
		   echo -ne '#############             (66%)\r'
		   sleep 1
		   echo -ne '#######################   (100%)\r'
		   echo -ne '\n'
		   read -rsp $'All done with this Firewalk scan. Press enter to continue...\n';;
		4) echo ""
		   echo Firewalk Scan Starting
		   echo ""
		   echo "IMPORTANT PLEASE READ!"
		   echo "In order for the Firewalk script to work you must"
		   echo "format your targets.txt file a specific way. Make"
		   echo "sure that your hosts are all on one line, and there"
		   echo "are no commas in between each host before you run Firewalk"
		   echo "(i.e. 10.1.1.1 10.2.2.2 10.3.3.3 dontgothere.com)"
		   echo ""
		   echo "Enter the name for the file output (no spaces)"
		   read file
		   mkdir ~/Desktop/$client/NMAP/Firewalk/
		   `nmap --append-output --script=firewalk --traceroute -Pn -iL ~/Desktop/targets.txt > ~/Desktop/$client/NMAP/Firewalk/firewalk_Pn_$currentDate.txt`
		   read -rsp $'All done with this Firewalk scan. Press enter to continue...\n';;
		5) echo ""
		   echo "Enter a single IP or domain name"
		   read host
		   echo ""
		   mkdir ~/Desktop/$client/NMAP/Firewalk/
		   `nmap --append-output --script=firewalk --traceroute "$host" > ~/Desktop/$client/NMAP/Firewalk/$currentDate-firewalk_single_host.txt`
		   read -rsp $'All done with this Firewalk scan. Press enter to continue...\n';;
		6) echo ""
		   echo "Whois Lookup Starting"
		   echo ""
		   echo "Please enter a domain name for a Whois lookup"
		   read dn
		   whois "$dn" > ~/Desktop/$client/Whois/Whois_$currentDate.txt
		   read -rsp $'All done with this WhoIs lookup. Press enter to continue...\n';;
		7) echo ""
		   echo "NSLookup Starting (DNS and MX)"
		   echo ""
		   echo "Enter a single domain name"
		   read dn
		   nslookup -type=ns $dn > ~/Desktop/$client/NSLookup/dns_$dn-$currentDate.txt
		   nslookup -type=mx $dn > ~/Desktop/$client/NSLookup/mx_$dn-$currentDate.txt
		   read -rsp $'All done with this nslookup. Press enter to continue...\n';;
		8) echo ""
		   echo "Email Harvest Starting"
		   echo ""
		   echo "Enter a single domain name"
		   read dn
		   theHarvester -d "$dn" -l 500 -b google > ~/Desktop/$client/Harvester/harvester_$dn-$currentDate.txt
		   read -rsp $'All done with this email harvest. Press enter to continue...\n';;
		9) echo ""
		   echo "Fierce DNS Scan Starting"
		   echo ""
		   echo "Enter a single domain name"
		   read dn
		   #Change path to Fierce here
		   nmap --script dns-brute $dn > ~/Desktop/$client/Fierce/DNS_Brute_$dn-$currentDate.txt
		   fierce --domain $dn > ~/Desktop/$client/Fierce/FierceDNS_$dn-$currentDate.txt
		   read -rsp $'All done with this Fierce DNS scan. Press enter to continue...\n';;
		10) echo ""
		    echo "Nikto Website Vulnerability Scan Starting"
		    echo ""
		    echo "Enter a single domain name"
		    read dn
                    cd /var/lib/nikto
                    git pull https://github.com/sullo/nikto
                    cd ~/Desktop/$client
		    nikto -host $dn > ~/Desktop/$client/Nikto/nikto_$dn-$currentDate.txt -p 80,443
		    read -rsp $'All done with this Nikto scan. Press enter to continue...\n';;
		11) echo ""
		    echo "Joomla Vulnerability Scan Starting"
		    echo "Enter a single domain name"
		    read dn
		    mkdir ~/Desktop/$client/Joomla
		    joomscan update
		    joomscan -u $dn > ~/Desktop/$client/Joomla/joomla_$dn-$currentDate.txt
		    read -rsp $'All done with this Joomla scan. Press enter to continue...\n';;
		12) echo ""
		    echo "Hydra Password Attack Starting"
		    echo ""
		    echo "Enter the URL and service to attack"
		    echo "i.e. ftp://thatdomain.com, ssh://thatdomain.com"
		    read url
		    echo "Make sure you have users.txt, and passwords.txt on your Desktop!"
		    echo ""
		    mkdir ~/Desktop/$client/Hydra
		    hydra -L ~/Desktop/users.txt -P ~/Desktop/passwords.txt $url > ~/Desktop/$client/Hydra/hydra_$currentDate.txt
		    read -rsp $'All done with this Hydra scan. Press enter to continue...\n';;
		13) echo ""
		    echo "WordPress Vulnerability Scan Starting"
		    echo ""
		    echo "Enter the URL to scan"
		    read url
		    echo ""
		    	wpscan --update --url $url --ignore-main-redirect --stealthy --format cli-no-colour --output ~/Desktop/$client/WPScan/WPScan_$url-$currentDate.txt;;
		14) echo ""
		    echo "Enter the URL to scan"
		    read dn
		    echo ""
		    echo -ne '#                            (1%) (nmap_FIN_ACK)\r'
		    sleep 1
  		   `nmap -sM --append-output --host-timeout 30m -iL ~/Desktop/targets.txt > ~/Desktop/$client/NMAP/nmap_FIN_ACK.txt`
		    echo -ne '\033[K######                       (30%) (nmap_TCP_SYN)\r'
		    sleep 1
   		   `nmap -sS -sV -O --append-output --host-timeout 30m -iL ~/Desktop/targets.txt > ~/Desktop/$client/NMAP/nmap_TCP_SYN.txt`
		    echo -ne '\033[K###########                  (45%) (nmap_TCP_FIN)\r'
		    sleep 1
  		   `nmap -sF --append-output --host-timeout 30m -iL ~/Desktop/targets.txt > ~/Desktop/$client/NMAP/nmap_TCP_FIN.txt`
		    echo -ne '\033[K####################         (65%) (nmap_UDP)\r'
		    sleep 1
  		   `nmap -sU --append-output --host-timeout 30m -iL ~/Desktop/targets.txt > ~/Desktop/$client/NMAP/nmap_UDP.txt`
		    echo -ne '\033[K########################     (81%) (whois)\r'
		    sleep 1
		   whois "$dn" > ~/Desktop/$client/Whois/Whois_$dn-$currentDate.txt
			 echo -ne '\033[K#########################    (83%) (reverse-ip-lookup)\r'
			 sleep 1
			 curl -s https://api.hackertarget.com/reverseiplookup/?q=$dn > ~/Desktop/$client/HackerTarget/reverse-ip-lookup-$dn-$currentDate.txt
		   echo -ne '\033[K##########################    (85%) (nslookup dns)\r'
		   sleep 1
		   nslookup -type=ns $dn > ~/Desktop/$client/NSLookup/dns_$dn-$currentDate.txt
		   echo -ne '\033[K###########################   (89%) (nslookup mx)\r'
		   sleep 1
		   nslookup -type=mx $dn > ~/Desktop/$client/NSLookup/mx_$dn-$currentDate.txt
		   echo -ne '\033[K############################  (93%) (harvester)\r'
		   sleep 1
		   theHarvester -d "$dn" -l 500 -b google > ~/Desktop/$client/Harvester/harvester_$dn-$currentDate.txt
		   echo -ne '\033[K############################# (96%) (fierce DNS_Brute)\r'
		   sleep 1
		   nmap --script dns-brute $dn > ~/Desktop/$client/Fierce/DNS_Brute_$dn-$currentDate.txt
		   echo -ne '\033[K##############################(98%) (fierce DNS)\r'
		   sleep 1
		   fierce --domain $dn > ~/Desktop/$client/Fierce/FierceDNS_$dn-$currentDate.txt
		   echo -ne '\033[K##############################(99%) (nikto)\r'
		   sleep 1
		   nikto -host $dn > ~/Desktop/$client/Nikto/nikto_$dn-$currentDate.txt -p 80,443
		   echo -ne '\033[K##############################(99%) (WPScan)\r'
		   sleep 1
		   wpscan --update --url $dn --ignore-main-redirect --stealthy --format cli-no-colour --output ~/Desktop/$client/WPScan/WPScan_$dn-$currentDate.txt
			 echo -ne '\033[K##############################(99%) (metagoofil)\r'
			 sleep 1
			 metagoofil -d "$dn" -t pdf,doc,xls,ppt,docx,pptx,xlsx -l 300 -n 75 -o ~/Desktop/$client/Metagoofil/ -w
			 exiftool -r *.doc *.xls *.ppt *.pptx *.xlsx *.pdf | egrep -i "Author|Creator|Email|Produce|Template" | sort -u > ~/Desktop/$client/Metagoofil/metadata.txt
		   read -rsp $'All done with this All-in-One scan. Press enter to continue...\n';;
		15) echo ""
		    echo "Enter the URL to scan"
		    read dn
		    echo ""
		    echo -ne '#                         (1%) (whois)\r'
		    sleep 1
				echo -ne '\033[K##     (10%) (reverse-ip-lookup)\r'
 			  sleep 1
 			  curl -s https://api.hackertarget.com/reverseiplookup/?q=$dn > ~/Desktop/$client/HackerTarget/reverse-ip-lookup-$dn-$currentDate.txt
		    whois "$dn" > ~/Desktop/$client/Whois/Whois_$dn-$currentDate.txt
		    echo -ne '\033[K#####                     (17%) (nslookup dns)\r'
		    sleep 1
		    nslookup -type=ns $dn > ~/Desktop/$client/NSLookup/dns_$dn-$currentDate.txt
		    echo -ne '\033[K#########                 (35%) (nslookup mx)\r'
		    sleep 1
		    nslookup -type=mx $dn > ~/Desktop/$client/NSLookup/mx_$dn-$currentDate.txt
		    echo -ne '\033[K#############             (57%) (harvester)\r'
		    sleep 1
		    theHarvester -d "$dn" -l 500 -b google > ~/Desktop/$client/Harvester/harvester_$dn-$currentDate.txt
		    echo -ne '\033[K#################         (70%) (fierce DNS_Brute)\r'
		    sleep 1
		    nmap --script dns-brute $dn > ~/Desktop/$client/Fierce/DNS_Brute_$dn-$currentDate.txt
				echo -ne '\033[K###################       (80%) (fierce DNS)\r'
				sleep 1
				fierce --domain $dn > ~/Desktop/$client/Fierce/FierceDNS_$dn-$currentDate.txt
		    echo -ne '\033[K#######################   (93%) (nikto)\r'
		    sleep 1
		    nikto -host $dn > ~/Desktop/$client/Nikto/nikto_$dn-$currentDate.txt -p 80,443
		    echo -ne '\033[K##############################(96%) (WPScan)\r'
		    sleep 1
		    wpscan --update --url $dn --ignore-main-redirect --stealthy --format cli-no-colour --output ~/Desktop/$client/WPScan/WPScan_$dn-$currentDate.txt
				echo -ne '\033[K##############################(99%) (metagoofil)\r'
 			 sleep 1
 			 metagoofil -d "$dn" -t pdf,doc,xls,ppt,docx,pptx,xlsx -l 300 -n 75 -o ~/Desktop/$client/Metagoofil/ -w
			 exiftool -r *.doc *.xls *.ppt *.pptx *.xlsx *.pdf | egrep -i "Author|Creator|Email|Produce|Template" | sort -u > ~/Desktop/$client/Metagoofil/metadata.txt
		    read -rsp $'All done with this All-in-One scan. Press enter to continue...\n';;
		16) echo ""
		    echo "Enter a URL to scan for documents"
		    read dn
		    echo ""
		    metagoofil -d "$dn" -t pdf,doc,xls,ppt,docx,pptx,xlsx -l 300 -n 75 -o ~/Desktop/$client/Metagoofil/ -w
                     exiftool -r *.doc *.xls *.ppt *.pptx *.xlsx *.pdf | egrep -i "Author|Creator|Email|Produce|Template" | sort -u > ~/Desktop/$client/Metagoofil/metadata.txt
		    read -rsp $'All done with metadata gathering. Press any key to continue...\n';;
		17) break;;
		*) Pause "Select between 1 to 17 only"
	esac
done
