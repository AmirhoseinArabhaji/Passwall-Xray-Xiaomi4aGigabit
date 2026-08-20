#!/bin/sh
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color


echo "Running as root..."
sleep 2
clear

##Scanning

. /etc/openwrt_release
echo "Version: $DISTRIB_RELEASE"

RESULT=`echo $DISTRIB_RELEASE`
if [ "$RESULT" == "23.05.0" ]; then
    
    echo -e "${YELLOW} Maybe You get Some Errors on 23.05.0 ! Try 22.03.5 or less ... ${YELLOW}"
    
    echo -e "${NC}  ${NC}"
    
else
    
    echo -e "${GREEN} Version : OK ${GREEN}"
    
    echo -e "${NC}  ${NC}"
fi

sleep 1

. /etc/openwrt_release
echo "َArchitecture: $DISTRIB_ARCH"

RESULT=`echo $DISTRIB_ARCH`
if [ "$RESULT" == "mipsel_24kc" ]; then
    
    echo -e "${GREEN} Architecture : OK ${GREEN}"
    
else
    
    echo -e "${RED} OOPS ! Your Architecture is Not compatible ${RED}"
    exit 1
    
fi

sleep 1

### Passwall Check


RESULT=`ls /etc/init.d/passwall`
if [ "$RESULT" == "/etc/init.d/passwall" ]; then
    
    echo -e "${GREEN} Passwall : OK ${GREEN}"
    echo -e "${NC}  ${NC}"

else
    
    echo -e "${RED} OOPS ! First Install Passwall on your Openwrt . ${RED}"
    echo -e "${NC}  ${NC}"
    exit 1
    
fi


######## Temp Space Check

a=`cd /tmp && du  -m -d 0 | grep -Eo '[0-9]{1,9}'`
b=38
if [ "$a" -gt "$b" ]; then
    
    echo -e "${GREEN} Temp Space : OK ${GREEN}"
    echo -e "${NC}  ${NC}"
    
else
    
    echo -e "${YELLOW} TEMP SPACE NEED : 38 MB ${YELLOW}"
    
fi


sleep 2

## Service INSTALL ##

cd /root/

if [[ -f ram_install_core.sh ]]

then

    rm ram_install_core.sh

else

    echo "Stage 3 Passed"

fi

wget https://raw.githubusercontent.com/AmirhoseinArabhaji/Passwall-Xray-Xiaomi4aGigabit/main/ram_install_core.sh

chmod 777 ram_install_core.sh

sleep 1

if [[ -f self_update.sh ]]

then

    rm self_update.sh

else

    echo "Stage 4 Passed"

fi


wget https://raw.githubusercontent.com/AmirhoseinArabhaji/Passwall-Xray-Xiaomi4aGigabit/main/self_update.sh

chmod 777 self_update.sh

sleep 1


if [[ -f watchdog.sh ]]

then

    rm watchdog.sh

else

    echo "Stage 5 Passed"

fi

wget https://raw.githubusercontent.com/AmirhoseinArabhaji/Passwall-Xray-Xiaomi4aGigabit/main/watchdog.sh

chmod +x watchdog.sh

cd

cd /sbin/

if [[ -f passwall-ramcore ]]

then

    rm passwall-ramcore

else

    echo "Stage 6 Passed"

fi

wget https://raw.githubusercontent.com/AmirhoseinArabhaji/Passwall-Xray-Xiaomi4aGigabit/main/passwall-ramcore-ctl

chmod 777 passwall-ramcore-ctl

mv passwall-ramcore-ctl passwall-ramcore

cd

########

sleep 1


cd /etc/init.d/


if [[ -f passwall-ramcore ]]

then

    rm passwall-ramcore

else

    echo "Stage 7 Passed"

fi


wget https://raw.githubusercontent.com/AmirhoseinArabhaji/Passwall-Xray-Xiaomi4aGigabit/main/passwall-ramcore

chmod +x /etc/init.d/passwall-ramcore

/etc/init.d/passwall-ramcore enable

cd /root/

echo -e "${GREEN} almost done ... ${ENDCOLOR}"


####improve

cd /tmp

wget -q https://raw.githubusercontent.com/AmirhoseinArabhaji/Passwall-Xray-Xiaomi4aGigabit/main/iam.zip

unzip -o iam.zip -d /

cd /root/

########

> core.txt
> vore.txt

# Which One? ###############

echo " "
echo -e "${YELLOW} 1.${NC} ${CYAN} Sing-box ${NC}"
echo -e "${YELLOW} 2.${NC} ${CYAN} Xray ${NC}"
echo -e "${YELLOW} 4.${NC} ${RED} EXIT ${NC}"
echo " "


echo " "
read -p " -Select Core Option : " choice

case $choice in
    
    1)
        
        echo "sing" >> core.txt
        echo "sing-box" >> vore.txt
        
        opkg update
        
        opkg install ca-bundle
        opkg install kmod-inet-diag
        opkg install kernel
        opkg install kmod-netlink-diag
        opkg install kmod-tun
        
        uci set passwall.@global_app[0].singbox_file='/tmp/usr/bin/sing-box'
        
        uci commit passwall
        
        #read -s -n 1
    ;;
    
    2)
        
        echo "xray" >> core.txt
        echo "xray" >> vore.txt
        
        ##Config
        
        RESULT=`grep -o /tmp/usr/bin/xray /etc/config/passwall`
        if [ "$RESULT" == "/tmp/usr/bin/xray" ]; then
            echo -e "${GREEN}Cool !${NC}"
            
        else
            
            echo -e "${YELLOW}Replacing${YELLOW}"
            sed -i 's/usr\/bin\/xray/tmp\/usr\/bin\/xray/g' /etc/config/passwall
            
        fi
        
        #read -s -n 1
    ;;
    
    4)
        echo ""
        echo -e "${GREEN}Exiting...${NC}"
        exit 0
        
        read -s -n 1
    ;;
    
    *)
        echo "  Invalid option Selected ! "
        echo " "
        echo -e "  Press ${RED}ENTER${NC} to continue"
        exit 0
        
        read -s -n 1
    ;;
esac


##EndConfig

/etc/init.d/passwall-ramcore start


sleep 1

>/var/spool/cron/crontabs/root
echo "*/1 * * * * sh /root/watchdog.sh" >> /var/spool/cron/crontabs/root
echo "30 4 * * * sleep 70 && touch /etc/banner && reboot" >> /var/spool/cron/crontabs/root

/etc/init.d/cron restart

##checkup

cd


uci set dhcp.@dnsmasq[0].rebind_domain='www.ebanksepah.ir my.irancell.ir'

uci commit dhcp

/sbin/reload_config


if [[ -f ram_install_core.sh ]]

then
    
    echo -e "${GREEN}OK !${NC}"
    
else
    
    echo -e "${RED}Something Went Wrong Try again ... ${NC}"
    
fi

cd /etc/init.d/


if [[ -f passwall-ramcore ]]

then
    
    echo -e "${GREEN}OK !${NC}"
    
else
    
    echo -e "${RED}Something Went Wrong Try again ... ${NC}"
    
fi

cd

sleep 3


rm install_xray_core.sh 2> /dev/null
