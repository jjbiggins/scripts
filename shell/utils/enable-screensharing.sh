#!/bin/bash

arg=$1
if [[ "$arg" == "activate" ]]; then
    sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate;
fi

if [[ "$arg" == "restart" ]]; then
    sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent;
fi

if [[ "$arg" == "enableAllUsers" ]]; then
    sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -allowAccessFor -allUsers -privs -all -clientopts -setmenuextra -menuextra yes;
fi

