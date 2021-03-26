#!/bin/bash

if [ $# -ne 2 ]; then
    echo "2 directory paths must be entered."
    exit 1
fi

if [ ! -d $1 ] || [ ! -d $2 ]; then
    echo "Specified directory doesn't exist."
    exit 1
fi

files=$(echo "$(ls $1) $(ls $2)" | xargs -n1 | sort -u)

for file in $files
do
    if [ $1$file -nt $2$file ]; then echo "$1$file --> $(echo $2 | sed -r 's/(.*)\//\1/')"
    elif [ $2$file -nt $1$file ]; then echo "$2$file --> $(echo $1 | sed -r 's/(.*)\//\1/')"
    fi
done