#!/bin/bash
#Check if we're in the right folder (rTorrent seems to bug sometimes)
if [ "$(ls -d $1 | grep -F /data/download/torrent/)" ]; then
        #Create only 1 instance of this script to avoid rTorrent crashing
        if [ ! "$(ls /config/scripts | fgrep -i pidfile)" ]; then
                yes no | touch /config/scripts/pidfile
                #Find and repeat for all folders and subfolders
                for directory in $(find $1 -type d); do
                        #Check for .rar files and unpack them if found
                        if [ "$(ls $directory | fgrep -i .rar)" ]; then
                                rarFile=`ls $directory | fgrep -i .rar`;
                                searchPath="$directory/$rarFile"
                                yes no | unrar x -o+ $searchPath $directory
                        #Check for .001 files and unpack them if found
                        elif [ "$(ls $directory | fgrep -i .001)" ]; then
                                rarFile=`ls $directory | fgrep -i .001`;
                                searchPath="$directory/$rarFile"
                                yes no | unrar x -o+ $searchPath $directory
                        #Check for .zip files and unpack them if found
                        elif [ "$(ls $directory | fgrep -i .zip)" ]; then
                                for zipFiles in `ls $directory | fgrep -i .zip`; do
                                        searchPath="$directory/$zipFiles"
                                        yes no | unzip -n $searchPath -d $directory
                                done
                                #When there is .zip files there are often .rar/.001 in them. Check and unpack if so
                                if [ "$(ls $directory | fgrep -i .rar)" ]; then
                                rarFile=`ls $directory | fgrep -i .rar`;
                                searchPath="$directory/$rarFile"
                                yes no | unrar x -o+ $searchPath $directory
                                #Check for .001 files and unpack them if found
                                elif [ "$(ls $directory | fgrep -i .001)" ]; then
                                rarFile=`ls $directory | fgrep -i .001`;
                                searchPath="$directory/$rarFile"
                                yes no | unrar x -o+ $searchPath $directory
                                fi
                        fi
                done
                yes no | rm -f /config/scripts/pidfile
        fi
fi