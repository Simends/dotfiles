#!/bin/sh

echo -e "\nsession\toptional\tpam_exec.so /usr/local/bin/pam_s6_usertree.sh" >> /etc/pam.d/system-login
