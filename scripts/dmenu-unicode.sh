#!/bin/sh

# The famous "get a menu of emojis to copy" script.

# Get user selection via dmenu from emoji file.
chosen=$(cut -d ';' -f1 ~/.local/dotfiles/data/emoji | dmenu $1 | sed "s/ .*//")

# Exit if none chosen.
[ -z "$chosen" ] && exit

# If you run this command with an argument, it will automatically insert the
# character. Otherwise, show a message that the emoji has been copied.
if [ -n "$1" ]; then
	printf "$chosen" | xclip -selection clipboard
	notify-send "'$chosen' copied to clipboard." &
else
	xdotool type "$chosen"
fi
