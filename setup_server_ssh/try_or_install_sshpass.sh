#!/bin/bash


if ! command -v sshpass >/dev/null; then
    echo "checking for sshpass....NO"
    read -p "sshpass is required, do you want attempt to install [Y/n]: " should_install

    lower_should_install=$(echo "$should_install" | tr '[:upper:]' '[:lower:]')
    if [[ "${lower_should_install}" == "y" ]]; then
	:
    fi
fi
