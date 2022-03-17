#!/bin/sh

MenuOpts="$1"
MenuProg="dmenu $MenuOpts"
Terminal="$2"
Browser="$3"

SelectionPass=$(ls "$PASSWORD_STORE_DIR"/*/*.gpg | awk -F "/" '{print $(NF-1), $NF}' | sed 's/.gpg$//' | $MenuProg)
if [ ! -z "${SelectionPass}" ]; then
    PassOptions=$(echo -e "Password\nUsername\nOTP Code" | $MenuProg)
    case "$PassOptions" in
        "Password")
            echo "$SelectionPass" \
                | sed 's| |/|' \
                | xargs -r pass show \
                | head -n1 \
                | xclip -selection clip-board \
                && notify-send "Password copied!" "Password for $SelectionPass has been copied to clipboard"
            ;;
        "Username")
            echo "$SelectionPass" \
                | sed 's| |/|' \
                | xargs -r pass show \
                | grep -oP "(?<=user: )\S*$" \
                | xclip -selection clip-board \
                && notify-send "Username copied!" "Username for $SelectionPass has been copied to clipboard"
            ;;
        "OTP Code")
            echo "$SelectionPass" \
                | sed 's| |/|' \
                | xargs -r pass otp code \
                | xclip -selection clip-board \
                && notify-send "OTP Code copied!" "One time code for $SelectionPass has been copied to clipboard"
            ;;
    esac
fi
