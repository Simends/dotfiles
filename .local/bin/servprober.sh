#!/usr/bin/env bash

numsv=$(ls /run/service/ | wc -l)
chk=0

for ((i=1; i<=$numsv; i++))
do
    sv=$(ls /run/service/ | sed -n "$i"p)
    ecode=$(echo "/run/service/$sv" | xargs sudo s6-svstat -e)
    if [ $((ecode)) != -1 ] && [ $((ecode)) != 0 ];
    then
        echo "$sv encountered an error and exited with exit code: $ecode"
        chk=1
    fi
done

if [ $((chk)) == 0 ];
then
    echo "No errors to report"
fi
