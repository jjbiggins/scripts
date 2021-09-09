#!/bin/bash

source ~/.functions

APPCODE=dotfiles
indir="$HOME/Applications/Shell/data/$APPCODE/input"
datadir="$HOME/Applications/Shell/data/$APPCODE/data"
archive="$HOME/Applications/Shell/data/$APPCODE/archive"
datapar=`dirname $datadir`
logfile=$datadir/process.lst

if [[ -f $logfile ]]; then
    echo "------------------------------------------------------" >>$logfile
    echo "    LOGFILE: $datadir/process.lst exists                " >>$logfile
    echo "------------------------------------------------------" >>$logfile
else
    >$datadir/process.lst
    logfile=$datadir/process.lst
fi


# count the output records
filename=$indir/dot
num=`wc -l "$indir/dot"`
remote_dir=`/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --get remote.origin.url`
last_commit=`/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config log -n 1`
contents=`cat $indir/dot`
echo " " >>$logfile
echo "                  INPUT FILENAME: $filename "         >>$logfile
echo "                  NUMBER OF DIRECTORIES: $num "       >>$logfile
echo "                  REMOTE DIR: $remote_dir "           >>$logfile
echo "                  LAST COMMIT: $last_commit "         >>$logfile
echo "                  CONTENTS: $contents "               >>$logfile
echo "===========================================================================" >>$logfile
echo " CONFIG STATS " >>$logfile
echo "===========================================================================" >>$logfile


timestamp=`date '+%Y-%m-%d_%H-%M-%S'`
archive="ar_${timestamp}"

if [ -d $datapar/archive/$archive ]
then
        sleep 2
        ts=`date '+%Y-%m-%d_%H-%M-%S'`
        archive=${archive}_${ts}
fi

rm "$datadir"
mkdir $datapar/$archive
ln -s $datapar/$archive $datadir


shopt -s expand_aliases
source ~/.bashrc_aliases

cd $indir
>$datadir/dotfile_files
while read line
do
    dir="$HOME/$line"
    echo "$dir" >> $datadir/dotfile_files
done<$indir/dot

cp $datadir/dotfile_files $datadir/input.raw

echo "">>$logfile 
echo "---------------------------------------------------------------">>$logfile
echo "              ADDING FILES TO COMMIT                           ">>$logfile
echo "---------------------------------------------------------------">>$logfile
while read line
do
    echo "$line" >> $logfile
    if [[ ! -z "$line"  ]]; then
        /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME add "$line"
        config=`/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME add "$line"`
        echo "config add $line"
    fi
done<$datadir/input.raw


total_output=`/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME status`
total_input=`wc -l "$indir/dot"`
echo " " >>$logfile
echo "                     Host Computer: $HOSTNAME " >>$logfile
echo "             application directory: $appdir "             >>$logfile
echo "               total input records: $total_input "     >>$logfile
echo "              total output records: $total_output "     >>$logfile
echo " " >>$logfile
echo " **************************************************************************** " >> $logfile
echo " The input and output quantities above should match. " >> $logfile
echo " **************************************************************************** " >> $logfile


BACK_PID=$!

message="daily cron commit"
echo ""
echo "$message"
echo ""
call /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME  commit -m "\"$message\""
wait $BACK_PID

call /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME push
wait $BACK_PID

mv $datapar/$archive $datapar/archive/
unlink $datadir
/opt/local/bin/gln -s $datapar/archive/$archive $datadir


good_exit
