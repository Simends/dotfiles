#! /bin/bash

dte(){
    dte="$(figlet "$(date "+%A%n%d / %m / %y")")"
    echo -e "$dte"
}
csf(){
    csf="$(cowsay "$(fortune)")"
    echo -e "\n\n$csf"
}
slock -m "$(dte) $(csf)"
