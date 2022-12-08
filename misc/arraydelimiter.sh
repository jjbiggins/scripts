#!/bin/bash

oIFS="$IFS"
IFS=$'\n'
arr=()

for line in $(find $1 -maxdepth 1 -type d); do
  IFS=':'
	eh
  arr+=($line)
  echo "result... ${arr[@]}"  #not assigning a variable, just testing the output
	echo "${#arr[@]}"
  # etc..
done
IFS="$oIFS"
