#!/bin/sh

MenuOpts="$1"
MenuProg="dmenu $MenuOpts"
Terminal="$2"
Browser="$3"
Bookmarkdir="$HOME/.local/dotfiles/bookmarks"

search() {
    SearchEngines="Ducduckgo: duckduckgo.com/?q=
Wikipedia (NO): no.wikipedia.org/w/index.php?search=
Wikipedia (EN): en.wikipedia.org/w/index.php?search=
Store Norske Leksikon: snl.no/
Arch Linux Wiki: wiki.archlinux.org/index.php?search=
Arch Linux Packages: archlinux.org/packages/?sort=&q=
Arch Linux AUR: aur.archlinux.org/packages/?O=0&K=
Norske Akademikers Ordbok: naob.no/søk/
Gentoo Linux Wiki: wiki.gentoo.org/index.php?Search&search=
Distrowatch: distrowatch.com/table.php?distribution=
Github: github.com/search?q=
Sourcehut: sr.ht/projects?search=
Youtube: youtube.com/results?search_query=
Standard Ebooks: standardebooks.org/ebooks?query=
Z-Library: 1lib.sk/s/"

    SelEngine=$(echo -e "$SearchEngines" | $MenuProg | awk '{print $NF}')
    SearchTerm=$(echo "" | $MenuProg)
    $Browser "https://$SelEngine$SearchTerm"
}

bookmarks() {
    cat $Bookmarkdir/* | $MenuProg | cut -d'|' -f2 | xargs $Browser
}

SelOpt=$(echo -e "Search\nBookmarks" | $MenuProg)
case "$SelOpt" in
    "Search")
        search
        ;;
    "Bookmarks")
        bookmarks
        ;;
esac
