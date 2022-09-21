#!/bin/bash


URL=$1
wget --mirror --convert-links --html-extension --wait=2 -o wget-mirror.log "$URL"
