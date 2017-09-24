#!bin/bash
#
# This will take all files in a directory and move them into subfodlers 
# of the same name as the file
for f in *; do
    name=`echo "$f"|sed 's/ -.*//'`
    dir="DestinationDirectory/$name"
    mkdir -p "$dir"
    mv "$f" "$dir"
done
