#!/bin/bash

echo "====================================================================================="
echo "|     GROUP      |                           MEMBERS                                |"
echo "====================================================================================="


getent group | awk -F'[:]' {'if ($4!="") printf ("%s -- %s\n", $1, $4)'} | column -t | awk -F, -v f=1 -v t=6  '{for(i=f;i<=t;i++) printf("%s  %s  %s  %s", " ", ($i!="")?$i:"\033[3C", (i==t)?"\n":OFS, " ") }' | column -t | awk '{printf("| %s ", $1); for(i=3;i<NF;i++) printf("|\033[3C%s %s", ($i!="\033[3C")?$i"\033[1C":"\033[1C", (i<(NF-1))?"":"|\n") }' | column -t




echo "====================================================================================="
