#!/bin/bash


cat "$HOME/.passwd" | grep "$USER" | cut -d ":" -f2 | sudo -S port -dN selfupdate && sudo port -uR upgrade outdated;


