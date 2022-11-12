#!/bin/bash

COPY_TO_DIR=$1
while read line; do

    if file $line | cut -d ':' -f2 | grep -q Python >/dev/null ; then
	cp "$line" "$COPY_TO_DIR"
    fi
done<$2
