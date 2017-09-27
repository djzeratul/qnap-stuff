#!/bin/bash
#log
touch /share/Container/script/logs/artwork.log
#Just run filebot artwork downloader on all files less than 1 day old
filebot.sh -script fn:artwork.tmdb --def maxAgeDays=1 /share/HD/ >> /share/Container/script/logs/artwork.log &
MaxFileSize=5242880
while true
    do
        #Get size in bytes** 
        file_size=`du -b /share/Container/script/logs/artwork.log | tr -s '\t' ' ' | cut -d' ' -f1`
        if [ $file_size -gt $MaxFileSize ];then   
            timestamp=`date +%s`
            mv /share/Container/script/logs/artwork.log /share/Container/script/logs/artwork.log.$timestamp
            touch /share/Container/script/logs/artwork.log
        fi
done