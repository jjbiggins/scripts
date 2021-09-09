#!/bin/bash

pass=`cat $HOME/.passwd | grep $USER | cut -d ':' -f2`

echo "$pass" | sudo -S port installed | grep -v active | while read line;
do
    macport=`echo "$line" | sed 's/ //g'`
    echo "$pass" | sudo -S port uninstall "$macport" &

    BACK_PID=$!
    wait $BACK_PID
done

echo "$pass" | sudo -S port -v selfupdate &
BACK_PID=$!
wait $BACK_PID

echo "$pass" | sudo -S port upgrade outdated &
BACK_PID=$!
wait $BACK_PID

