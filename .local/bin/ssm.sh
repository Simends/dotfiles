#!/usr/bin/env bash

# Styling
RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[1;30m'
NC='\033[0m'
BOLD='\033[1m'

svnum=$(ls /run/service/ | wc -l)
svtotnum=$(sudo s6-rc list default | wc -l)
li=" : : : : \nService:Status:Uptime:PID:Exit code\n-------:------:------:---:---------"

for ((i=1; i<=$svnum; i++))
do
    sv=$(ls /run/service/ | sed -n "$i"p)
    svstatus=$(sudo s6-svstat /run/service/$sv | awk '{print $1}')
    svtime=$(sudo s6-svstat -t /run/service/$sv)
    svtime=$((svtime/60))
    svtime="${CYAN}$svtime min${NC}"

    if [ $svstatus = "up" ];
    then
        svid=$(sudo s6-svstat -p /run/service/$sv)
        svid="${PURPLE}$svid${NC}"
        ecode="${GRAY}-${NC}"
        sv="${GREEN}${BOLD}$sv${NC}"
        svstatus="${GREEN}$svstatus${NC}"
    else
        svid="${GRAY}-${NC}"
        ecode=$(sudo s6-svstat -e /run/service/$sv)
        if [ $((ecode)) != 0 ];
        then
            ecode="${RED}$ecode${NC}"
        else
            ecode="${GRAY}$ecode${NC}"
        fi
        sv="${RED}${BOLD}$sv${NC}"
        svstatus="${RED}$svstatus${NC}"
    fi

    li="$li\n$sv:$svstatus:$svtime:$svid:$ecode"
done

printf "$li\n : : : : " | column -t -s ":"
echo "$svnum longruns and $svtotnum services in total"
