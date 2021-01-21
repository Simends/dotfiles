#!/usr/bin/bash

bkmrks=/home/simen/.config/shell/bookmarks.txt
numentries=$(cat $bkmrks | wc -l )
nnnb=""

for ((i=1; i<=$numentries; i++))
do
    pth=$(cat $bkmrks | sed -n "$i"p | awk '{print $3}')
    key=$(cat $bkmrks | sed -n "$i"p | awk '{print $2}')
    sed -i "/alias $key=/d" /home/simen/.config/shell/aliases
    echo "alias $key='cd $pth'" >> /home/simen/.config/shell/aliases
    nnnb="$key:$pth;$nnnb"
done

echo `sed -i '/export NNN_BMS=*/d' /home/simen/.config/shell/profile`
echo "export NNN_BMS='$nnnb'" >> /home/simen/.config/shell/profile
