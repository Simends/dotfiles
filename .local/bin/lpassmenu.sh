#!/bin/bash

lpass ls | awk '{print $1}' | sed 's+/+: +g' | dmenu -l 15 -p "LastPass" | awk '{print $2}' | xargs -r lpass show -c --password
