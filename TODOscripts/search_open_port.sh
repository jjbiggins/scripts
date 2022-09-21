#!/bin/bash

LAST_PORT=9000
HOST=192.168.1.254

for i in $(seq $LAST_PORT); do

    EXIT_CODE=$(python3 ~/scripts/keep/tcptestconnection.py  192.168.1.254 ${i} >/dev/null; echo $?)

    if [[ $EXIT_CODE -eq 0 ]]; then
	python3 ~/scripts/keep/tcptestconnection.py  192.168.1.254 ${i}	
    fi

done
