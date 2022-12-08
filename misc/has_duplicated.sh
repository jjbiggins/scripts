#!/bin/bash


UNIQ=1
USR_LOCAL_BIN=/usr/local/bin


for executable in ${USR_LOCAL_BIN}/*; do
    EXEC_BASENAME=$(basename "$executable")
    COUNT=$(type -a "$EXEC_BASENAME"  | wc -l)


    
    if [ "$COUNT" -gt "$UNIQ" ]; then
	which $executable >> /tmp/has_duplicates.log
	echo " " >> /tmp/has_duplicates.log
    fi
done


