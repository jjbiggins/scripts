#!/bin/bash


ESC="\033"
GREEN=$'\033[01;32m'
NC=$'\033[0;0m'


bot () {
    echo -e "\n\033[01;32m - "$1
}

ok () {
    echo -e "$GREEN[ok]$NC "$1
}


function running() {
    echo -en "$COL_YELLOW ⇒ $NC"$1": "
}

function action() {
    echo -e "\n$COL_YELLOW[action]:$NC\n ⇒ $1..."
}

function warn() {
    echo -e "$COL_YELLOW[warning]$NC "$1
}

function error() {
    echo -e "$COL_RED[error]$NC "$1
}

