#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color



echo "Running as root..."
sleep 1
clear

uci set system.@system[0].zonename='Asia/Tehran'
uci set system.@system[0].timezone='<+0330>-3:30'

uci commit system

/sbin/reload_config


# Scanning

. /etc/openwrt_release

echo "OPENWRT VERSION: $DISTRIB_RELEASE"

RESULT=`echo "$DISTRIB_RELEASE" | grep -o 23 | sed -n '1p'`

if [ "$RESULT" == "23" ]; then
    
    echo -e "${YELLOW} You are Running Openwrt Version 23. ! ${YELLOW}"
    echo -e "${YELLOW} IF You Want to install Orginal Passwall you need downgrade to openwrt 22.03  ${YELLOW}"
    echo -e "${YELLOW} At this momment You can just install Passwall 2 ${YELLOW}"
    
    # install passwall 2
    while true; do
        read -p "Do you wish to install Passwall 2 (y or n)? " yn
        case $yn in
            [Yy]* ) rm -f passwall2x.sh && wget https://raw.githubusercontent.com/AmirhoseinArabhaji/Passwall/main/install_passwall2x.sh && chmod 777 install_passwall2x.sh && sh install_passwall2x.sh;;
            [Nn]* ) echo -e "${MAGENTA} BYE ;) ${MAGENTA}" & exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
    
    exit 1
else
    
    echo -e "${GREEN} Version : Correct. ${GREEN}"
    
fi


### Update Packages ###

opkg update

# This part is from official passwall repo
# https://github.com/MoetaYuko/openwrt-passwall-build

# Add new okg key

wget -O passwall.pub https://master.dl.sourceforge.net/project/openwrt-passwall-build/passwall.pub

opkg-key add passwall.pub

>/etc/opkg/customfeeds.conf

# Add opkg repository

read release arch << EOF
$(. /etc/openwrt_release ; echo ${DISTRIB_RELEASE%.*} $DISTRIB_ARCH)
EOF
for feed in passwall_luci passwall_packages passwall2; do
    echo "src/gz $feed https://master.dl.sourceforge.net/project/openwrt-passwall-build/releases/packages-$release/$arch/$feed" >> /etc/opkg/customfeeds.conf
done

# Install package

opkg update
sleep 1
opkg install luci-app-passwall
sleep 1


opkg remove dnsmasq
sleep 1
opkg install ipset
sleep 1
opkg install ipt2socks
sleep 1
opkg install iptables
sleep 1
opkg install iptables-legacy
sleep 1
opkg install iptables-mod-conntrack-extra
sleep 1
opkg install iptables-mod-iprange
sleep 1
opkg install iptables-mod-socket
sleep 1
opkg install iptables-mod-tproxy
sleep 1
opkg install kmod-ipt-nat
sleep 1
opkg install dnsmasq-full
sleep 1
opkg install shadowsocks-libev-ss-local
sleep 1
opkg install shadowsocks-libev-ss-redir
sleep 1
opkg install shadowsocks-libev-ss-server
sleep 1
opkg install shadowsocksr-libev-ssr-local
sleep 1
opkg install shadowsocksr-libev-ssr-redir
sleep 1
opkg install simple-obfs
sleep 1
opkg install boost-system
sleep 1
opkg install boost-program_options
sleep 1
opkg install libstdcpp6
sleep 1
opkg install boost
sleep 1


# Adding custom passwall panel (new connection checks)

cd /tmp

wget -q https://github.com/AmirhoseinArabhaji/Passwall/blob/main/iam.zip

unzip -o iam.zip -d /

cd

########

sleep 1

RESULT=`ls /etc/init.d/passwall`

if [ "$RESULT" == "/etc/init.d/passwall" ]; then
    
    echo -e "${GREEN} Passwall Intalled! ${NC}"
    
else
    
    echo -e "${RED} Try another way ... ${NC}"
    
    cd /tmp/
    
    wget -q https://github.com/AmirhoseinArabhaji/Passwall/raw/main/pass.ipk
    
    opkg install pass.ipk
    
    cd
    
    echo -e "${RED} Passwall Can't Be Intalled! Try Again ... ${NC}"
    
    # Exit in case of error
    exit 1
    
fi


# Install xray core
opkg install xray-core


## IRAN IP BYPASS ##

cd /usr/share/passwall/rules/


if [[ -f direct_ip ]]

then
    
    rm direct_ip
    
else
    
    echo "Stage 1 Passed"
fi

wget https://raw.githubusercontent.com/AmirhoseinArabhaji/Passwall/main/direct_ip

sleep 3

if [[ -f direct_host ]]

then
    
    rm direct_host
    
else
    
    echo "Stage 2 Passed"
    
fi

wget https://raw.githubusercontent.com/AmirhoseinArabhaji/Passwall/main/direct_host

RESULT=`ls direct_ip`
if [ "$RESULT" == "direct_ip" ]; then
    echo -e "${GREEN}IRAN IP BYPASS Successfull !${NC}"
    
else
    
    echo -e "${RED}INTERNET CONNECTION ERROR!! Try Again ${NC}"
    
fi

sleep 1


RESULT=`ls /usr/bin/xray`

if [ "$RESULT" == "/usr/bin/xray" ]; then
    
    echo -e "${GREEN} Done ! ${NC}"
    
else
    
    rm -f install_xray_core.sh && wget https://raw.githubusercontent.com/AmirhoseinArabhaji/Passwall/main/install_xray_core.sh && chmod 777 install_xray_core.sh && sh install_xray_core.sh
    
fi

sleep 1

uci commit system

uci set passwall.@global[0].tcp_proxy_mode='global'
uci set passwall.@global[0].udp_proxy_mode='global'
uci set passwall.@global_forwarding[0].tcp_no_redir_ports='disable'
uci set passwall.@global_forwarding[0].udp_no_redir_ports='disable'
uci set passwall.@global_forwarding[0].udp_redir_ports='1:65535'
uci set passwall.@global_forwarding[0].tcp_redir_ports='1:65535'
uci set passwall.@global[0].remote_dns='8.8.4.4'
uci set passwall.@global[0].dns_mode='udp'
uci set passwall.@global[0].udp_node='tcp'

uci commit passwall

dhcp.@dnsmasq[0].rebind_domain='www.ebanksepah.ir' 'my.irancell.ir'

uci commit

echo -e "${YELLOW}** Warning : Router Will Be Rebooted ... **${ENDCOLOR}"

sleep 5

reboot

rm install_passwallx.sh 2> /dev/null

/sbin/reload_config

/etc/init.d/network reload
