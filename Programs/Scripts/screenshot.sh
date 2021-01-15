#! /bin/bash
# Small script to take screenshot with dmenu and scrot

case "$(printf "A selected window\\nCurrent window\\nBoth monitors\\nOnly the first monitor" | dmenu -l 6 -p "Screenshot which area?")" in
	"A selected window") scrot -sf -e 'mv $f ~/Multimedia/Pictures/Screenshots/' ;;
	"Current window") scrot -u -e 'mv $f ~/Multimedia/Pictures/Screenshots/' ;;
	"Both monitors") scrot -m -e 'mv $f ~/Multimedia/Pictures/Screenshots/' ;;
    "Only the first monitor") scrot -a $(xrandr | grep '\Wconnected\W' | grep -Po "\d+x\d+\+\d+\+\d+" | sed 's/x/+/' | awk -F "+" '{print $3","$4","$1","$2}' | head -n 1 | tail -n 1) -e 'mv $f ~/Multimedia/Pictures/Screenshots/' ;;
esac
