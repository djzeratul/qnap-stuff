#!/bin/bash
#change this to where you want to store your pidfile
pidDir='/config/scripts/pidfile'
#save current IFS value to restore after script runs
SAVEIFS=$IFS
#prevent spaces from interfering with for loop
IFS=$(echo -en "\n\b")
#Create only 1 instance of this script to avoid rTorrent crashing
if [ ! "$(ls /config/scripts | fgrep -i pidfile)" ]; then
        touch $pidDir
        #Find and repeat for all folders and subfolders
        for directory in $(find $inputdir -type d); do
                #Check for .rar files and unpack them if found
                if [ "$(ls $directory | fgrep -i .rar)" ]; then
                        rarFile=`ls $directory | fgrep -i .rar`;
                        searchPath="$directory/$rarFile"
                        unrar x -o+ $searchPath $directory
                #Check for .001 files and unpack them if found
                elif [ "$(ls $directory | fgrep -i .001)" ]; then
                        rarFile=`ls $directory | fgrep -i .001`;
                        searchPath="$directory/$rarFile"
                        unrar x -o+ $searchPath $directory
                #Check for .zip files and unpack them if found
                elif [ "$(ls $directory | fgrep -i .zip)" ]; then
                        for zipFiles in `ls $directory | fgrep -i .zip`; do
                                searchPath="$directory/$zipFiles"
                                unzip -n $searchPath -d $directory
                        done
                        #When there are .zip files there are often .rar/.001 in them. Check and unpack if so
                        if [ "$(ls $directory | fgrep -i .rar)" ]; then
                        rarFile=`ls $directory | fgrep -i .rar`;
                        searchPath="$directory/$rarFile"
                        unrar x -o+ $searchPath $directory
                        #Check for .001 files and unpack them if found
                        elif [ "$(ls $directory | fgrep -i .001)" ]; then
                        rarFile=`ls $directory | fgrep -i .001`;
                        searchPath="$directory/$rarFile"
                        unrar x -o+ $searchPath $directory
                        fi
                fi
        done
        rm -f $pidDir
fi
# restore $IFS
IFS=$SAVEIFS