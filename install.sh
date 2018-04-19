#!/bin/bash
#
#   Dante Socks5 Server AutoInstall
#   -- Owner:       https://www.inet.no/dante
#   -- Provider:    https://sockd.info
#   -- Author:      Lozy
#

REQUEST_SERVER="https://raw.github.com/sembruk/danted/master"
SYSTEM_RECOGNIZE=""

if [ -s "/etc/os-release" ];then
    os_name=$(sed -n 's/PRETTY_NAME="\(.*\)"/\1/p' /etc/os-release)

    if [ -n "$(echo ${os_name} | grep -Ei 'Debian|Ubuntu' )" ];then
        printf "Current OS: %s\n" "${os_name}"
        SYSTEM_RECOGNIZE="debian"
    else
        printf "Current OS: %s is not support.\n" "${os_name}"
    fi
else
    printf "[Error] (/etc/os-release) not exist!\n"
    printf "[Error] Current OS: is not available to support.\n"
fi

if [ -n "$SYSTEM_RECOGNIZE" ];then
    wget -qO- --no-check-certificate ${REQUEST_SERVER}/install_${SYSTEM_RECOGNIZE}.sh | \
        bash -s -- $*
else
    printf "[Error] Installing terminated"
    exit 1
fi

exit 0
