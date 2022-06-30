#!/bin/bash

pomofile="/tmp/pomodoro_status.txt"

start_pomo() {
    local i=0
    local wtime=25
    local btime=5
    while ((true))
    do
        for (($i=0;$i<wtime;$i++))
        do
            echo "Working: $i" > "$pomofile"
            sleep 1m
        done
        for (($i=0;$i<btime;$i++))
        do
            echo "Break: $i" > "$pomofile"
            sleep 1m
        done
    done
}

start_pomo
