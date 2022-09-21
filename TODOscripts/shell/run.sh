#! /bin/sh
# $Id: run.sh,v 1.1 2012/11/28 00:24:47 svnexp Exp svnexp $

PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin
export PATH

cd /local/svnexp || exit 1

echo ========= begin run
date
sh driver.sh base/stable/8 src.RELENG_8 "-r RELENG_8"
sh driver.sh base/stable/9 src.RELENG_9 "-r RELENG_9"
sh driver.sh base/releng/9.1 src.RELENG_9_1 "-r RELENG_9_1"
sh driver.sh base/releng/8.3 src.RELENG_8_3 "-r RELENG_8_3"
sh driver.sh base/releng/8.4 src.RELENG_8_4 "-r RELENG_8_4"
date
echo ========= end run
