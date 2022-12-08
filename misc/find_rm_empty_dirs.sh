#!/bin/bash

find /test -not -path '*/\.*' -type d \( ! -iname ".*" \) -empty -print0 | xargs -0  rm -v -rf "{}"

