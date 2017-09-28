#!/bin/bash
#vars change for your setup
script=./unrar_logic.sh
export inputdir=$1
log_location=/share/Container/rtorrent/config/scripts/logs/extract.log
#inst logfile
touch $log_location
#run logic script
$script >> $log_location &
pid=$!
MaxFileSize=5242880
while kill -0 $pid 2> /dev/null; do
        #Get size in bytes 
        file_size=`du -b $log_location | tr -s '\t' ' ' | cut -d' ' -f1`
        if [ $file_size -gt $MaxFileSize ];then   
            timestamp=`date +%F`
            mv $log_location $log_location.$timestamp
            touch $log_location
        fi
        sleep 1
done