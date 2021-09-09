#!/bin/bash

timestamp=`date`
echo "TEST MAIL SENT $timestamp" | mailx -s "TEST MAIL" josephjbiggins@gmail.com josephjbiggins@icloud.com jjbiggins@localhost.localdomain
