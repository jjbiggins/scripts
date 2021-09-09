#!/bin/bash

imac_user=$USER
imac_hostname=test.local
imac_user_pass=`cat ~/.personal/pass | grep local | tr $'\t' ' ' | cut -d ' ' -f2`
echo "$imac_user_pass"
sshpass -p "$imac_user_pass" ssh -t "${imac_user}@${imac_hostname}" 'osascript -e "set Volume 0"'
