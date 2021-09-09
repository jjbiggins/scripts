#!/bin/bash

while read line
do
    echo ""
    echo "$line"
    echo ""
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME add "$line"
done<config.cfg
