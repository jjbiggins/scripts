#!/bin/bash
cd /Library/PostgreSQL/13/bin

for x in *
do
    ln -s "$PWD/$x"  "/usr/local/bin/$x"
done

