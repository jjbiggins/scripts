#!/bin/bash

cat $HOME/.passwd | grep $USER | cut -d ':' -f2 | sudo -S periodic daily weekly monthly
