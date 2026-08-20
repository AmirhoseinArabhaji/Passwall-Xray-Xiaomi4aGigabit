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

sleep 3

clear

echo "Updating Please Wait..."

service passwall stop

cd /root/

rm -f ram_install_core.sh

wget https://raw.githubusercontent.com/AmirhoseinArabhaji/Passwall-Xray-Xiaomi4aGigabit/main/ram_install_core.sh

chmod 777 ram_install_core.sh

cd /etc/init.d/

rm -f passwall-ramcore

wget https://raw.githubusercontent.com/AmirhoseinArabhaji/Passwall-Xray-Xiaomi4aGigabit/main/passwall-ramcore

chmod +x /etc/init.d/passwall-ramcore

/etc/init.d/passwall-ramcore enable

cd /root/

/etc/init.d/passwall-ramcore start

echo -e "${GREEN} Update Complated ! ${ENDCOLOR}"