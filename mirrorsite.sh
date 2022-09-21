#!/bin/bash

URL=$1
wget --mirror --conver-links --html-extension --wait=2 "$URL"
