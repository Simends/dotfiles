#!/bin/sh
draw() {
  "${XDG_CONFIG_HOME}/lf/draw_img.sh" "$@"
  exit 1
}

hash() {
  printf '%s/.local/cache/lf/%s' "$HOME" \
    "$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}')"
}

cache() {
  if [ -f "$1" ]; then
    draw "$@"
  fi
}

file="$1"
shift

case "$file" in
    *.7z|*.a|*.ace|*.alz|*.arc|*.arj|*.bz|*.bz2|*.cab|*.cpio|*.deb|*.gz|*.jar|\
    *.lha|*.lrz|*.lz|*.lzh|*.lzma|*.lzo|*.rar|*.rpm|*.rz|*.t7z|*.tar|*.tbz|\
    *.tbz2|*.tgz|*.tlz|*.txz|*.tZ|*.tzo|*.war|*.xz|*.Z|*.zip)
        als -- "$file"
        exit 0
        ;;
    *.[1-8])
        man -- "$file" | col -b
        exit 0
        ;;
    *.djvu|*.djv)
        if [ -n "$FIFO_UEBERZUG" ]; then
            cache="$(hash "$file").tiff"
            cache "$cache"
            ddjvu -format=tiff -quality=90 -page=1 -size="${default_x}x${default_y}" \
            - "$cache" <"$file"
            draw "$cache"
        else
            djvutxt - <"$file"
            exit 0
        fi
        ;;
    *.docx|*.odt|*.epub)
        pandoc -s -t plain -- "$file"
        exit 0
        ;;
    *.htm|*.html|*.xhtml)
        # lynx -dump -- "$1"
        w3m -- "$file"
        exit 0
        ;;
    *.svg)
        if [ -n "$FIFO_UEBERZUG" ]; then
            cache="$(hash "$file").jpg"
            cache "$cache"
            convert -- "$file" "$cache"
            draw "$cache"
        fi
        ;;
esac

case "$(file -Lb --mime-type -- "$file")" in
    application/pdf)
        pdftotext -nopgbrk -q -- "$file" -
        exit 0
        ;;
    # test/html)
    #     w3m -- "$file"
    #     exit 0
    #     ;;
    text/*)
        highlight -q -O ansi -- "$file" || cat -- "$file"
        #pygmentize -f terminal -- "$1" || cat -- "$1"
        # source-highlight -q --outlang-def=esc.outlang --style-file=esc.style -i "$file" || cat -- "$file"
        # cat -- "$1"
        exit 0
        ;;
    image/*)
        if [ -n "$FIFO_UEBERZUG" ]; then
            orientation="$(identify -format '%[EXIF:Orientation]\n' -- "$file")"
            if [ -n "$orientation" ] && [ "$orientation" != 1 ]; then
                cache="$(hash "$file").jpg"
                cache "$cache" "$@"
                convert -- "$file" -auto-orient "$cache"
                draw "$cache" "$@"
            else
                draw "$file" "$@"
            fi
        fi
      ;;
    video/*)
        if [ -n "$FIFO_UEBERZUG" ]; then
            cache="$(hash "$file").jpg"
            cache "$cache" "$@"
            ffmpegthumbnailer -i "$file" -o "$cache" -s 0
            draw "$cache" "$@"
        fi
        ;;
esac

file -Lb -- "$1" | fold -s -w "$width"
exit 0
