#!/bin/bash

if [[ ! -z $1 ]]; then
    daysold=$1
else 
    echo "Usage: $0 [DAYS OLD] -- all files older than [DAYS OLD] will be removed"
    exit
fi

find . -mtime "+${daysold}" -print
read ans1; echo -e "The Above Files Will Be Deleted [Y/n]: " 
if  [ $ans1 =~ "N" ] || [ "ans1" =~ "n" ] ; then
    echo "Response: $ans1. Exiting ...."
    exit
fi

FILE_TO_REMOVE=($(find . -mtime "+${daysold}" -print))
for FILE in ${FILE_TO_REMOVE[@]}
do
    rm ${FILE} > /dev/null
    echo "$FILE"
done

echo "Have been deleted"
