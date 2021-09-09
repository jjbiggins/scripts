#!/bin/bash

tmlocal=($(tmutil listlocalsnapshots / | cut -d ':' -f2- ))
for snapshot in ${tmlocal[@]}
do
    if [[ "$snapshot" =~ "com.apple.TimeMachine" ]]; then
        suffix=`echo "$snapshot" | cut -d '.' -f4-5`
        diskimg=${suffix//.local/}
        cat "$HOME/.passwd" | grep "$USER" | cut -d ':' -f2- | sudo -S tmutil deletelocalsnapshots $diskimg
        sleep 7
    else
        echo "$snapshot"
    fi
done
