#!/bin/bash
DOCSDIR=$1; 

cd $DOCSDIR
SUBDIRS=($(find "$DOCSDIR" -depth 1 -type d -atime +10d ))

for dirtoarchive in ${SUBDIRS[@]}; do
    dir=$(basename "$dirtoarchive")
    tar -cJf ${dirtoarchive}.tar.xz ${dirtoarchive}

done
