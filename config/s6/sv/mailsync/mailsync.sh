#!/bin/sh

mailconfigdir="${XDG_CONFIG_HOME}/mail"
maildir="${XDG_DATA_HOME}/mail"

configs=$(find "${mailconfigdir}" -type f -iname "*.mbsyncrc")
confcount=$(echo "${configs}" | wc -l)
for ((i=1;i<="${confcount}";i++))
do
    config=$(echo "${configs}" | sed -n -e "${i}"p)
    echo "Syncing ${config}..."
    mbsync -c "${config}" -a &
done

while true
do
    pgrep mbsync >/dev/null || break
done

inboxes=$(find "${maildir}" -maxdepth 2 -type d -iname inbox)
inboxcount=$(echo "${inboxes}" | wc -l)
for ((i=1;i<="${inboxcount}";i++))
do
    inbox=$(echo "${inboxes}" | sed -n -e "${i}"p)
    inboxname=$(echo "${inbox}" | awk -F"/" '{print $(NF-1)}')
    newcount=$(find "${inbox}/new/" "${inbox}/cur/"\
        -type f -newer "${maildir}/.lastmailsync" 2>/dev/null | wc -l)
    echo "${newcount} new mails in ${inboxname}"

    if [ "${newcount}" != "0" ]
    then
        notify-send --app-name="mailsync" "New mail in ${inboxname}" "You've got ${newcount} new mail in ${inboxname}!"
    fi
done

touch "${maildir}/.lastmailsync"
