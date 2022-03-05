#!/bin/sh

echo "User is: ${PAM_USER}"
echo "Type is: ${PAM_TYPE}"

if [ "${PAM_USER}" == "simen" ]; then
    case "${PAM_TYPE}" in
        "open_session")
            s6-rc -uv 2 change usertree-simen
            s6-rc -uv 2 change userrc-simen
            ;;
        "close_session")
            s6-rc -dv 2 change userrc-simen
            s6-rc -dv 2 change usertree-simen
            ;;
    esac
fi
