#!/bin/bash

if [[  -z $1 ]]; then
    echo "usage: $0 GIT_DIR"
fi

GIT_DIR=$1
sudo -u root -c mkdir "/var/lib/git/${GIT_DIR}" &&\ 
    git init --separate-git-dir="/var/lib/git/${GIT_DIR}" --shared=group 

