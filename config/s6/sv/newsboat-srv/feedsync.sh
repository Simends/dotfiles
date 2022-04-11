#!/bin/sh

pgrep newsboat$ && exit
/usr/bin/newsboat --cleanup
/usr/bin/newsboat -x reload
unread=$(/usr/bin/newsboat -x print-unread)

echo "$unread" \
  | grep -P "^0 unread articles$" \
  || notify-send "New in feed" "There are $unread in feed"
