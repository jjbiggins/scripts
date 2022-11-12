#!/bin/bash


while read line; do 


    if ! grep -q "$line" bfs_res.txt; then 
	echo $line;
    fi 
done<treeres.txt
