#!/bin/sh

#
# TODO: Write a more comprehensive status line in this shell file
#
#   [X] Battery
#       * acpi -b
#   [-] Cpu
#   [X] Temp
#       * sensors
#   [X] Mem
#       * free
#   [-] Network
#   [X] git
#   [ ] Uptime
#       * uptime
#   [ ] Pomodoro
#

SEP=" #[fg=white]| "


git_component() {
    local s=''
    local branchName=''
    if [ "$(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}")" == '0' ]
    then
        if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]
        then
            if [[ -O "$(git rev-parse --show-toplevel)/.git/index" ]]
            then
                git update-index --really-refresh -q &> /dev/null
            fi
            if ! git diff --quiet --ignore-submodules --cached
            then
                s+='#[fg=green]'
            fi
            if ! git diff-files --quiet --ignore-submodules --
            then 
                s+='#[fg=yellow]'
            fi
            if [ -n "$(git ls-files --others --exclude-standard)" ]
            then
                s+='#[fg=red]'
            fi
            if git rev-parse --verify refs/stash &> /dev/null
            then
                s+='#[fg=gray]'
            fi
        fi
        branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || git rev-parse --short HEAD 2> /dev/null || echo '(unknown)')"
        echo -n "#[fg=magenta] ${1}${branchName} ${s}${SEP}"
    else
        return
    fi
}


bat_component() {
    local stat=$(acpi -b)
    local fstat=$(echo "$stat" | tr -d ',' | cut -d' ' -f3,4)
    local warn=$(echo "$fstat" | grep -qP "Discharging 2\d\%$" && echo "true" || echo "")
    local crit=$(echo "$fstat" | grep -qP "Discharging [1 ]\d\%$" && echo "true" || echo "")
    local fstat=$(echo "$fstat" | sed 's/Discharging/ /' | sed 's/Charging/#[fg=blue] /')
    if [ "$warn" ]
    then
        fstat="#[fg=yellow]$fstat"
    elif [ "$crit" ]
    then
        fstat="#[fg=red]$fstat"
    else
        fstat="#[fg=green]$fstat"
    fi
    echo -n "$fstat${SEP}"
}


temp_component() {
    local stat=$(sensors | grep "Package id 0:" | cut -d' ' -f5 | tr -d '+')
    stat=" $stat"
    echo "$stat" | grep -qP "[7-9]\d\.\d" &&\
        echo -n "#[fg=red]$stat${SEP}" ||\
        echo -n "$stat${SEP}"
}


mem_component() {
    local stat=$(free -h --giga | grep "Mem")
    local ustat=$(echo "$stat" | awk '{print $3}')
    local astat=$(echo "$stat" | awk '{print $4}')
    echo "$astat" | grep -qP "^\d[ \.]" &&\
        echo -n "#[fg=red] $ustat${SEP}" ||\
        echo -n " $ustat${SEP}"
}


clk_component() {
    echo -n "#[fg=cyan]$(date +'%H:%M')#[fg=white]"
}


bat_component

temp_component

mem_component

git_component

clk_component
