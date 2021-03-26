#!/bin/bash

if [ $# -gt 1 ]; then
    echo "Wrong number of arguments given."
    exit 1
fi

dir=$1

if [ ! -d $dir ]; then
    echo "Given directory doesn't exist."
    exit 1
fi

photos=$(ls $dir | sort)

month=0
year=0
counter=0

for photo in $photos
do
    current_month=$(echo $photo | sed -r 's/[[:digit:]]{4}([[:digit:]]{2}).*/\1/')
    current_year=$(echo $photo | sed -r 's/([[:digit:]]{4})[[:digit:]]{2}.*/\1/')
    if [ $month != $current_month ]; then
        if [ $counter -ne 0 ]; then
            echo "--- Ukupno: $counter slika -----"
        fi
        counter=0
        month=$current_month
        year=$current_year
        echo "$current_month-$current_year :"
        echo "----------"
    fi
    counter=$((counter+1))
    echo "$counter. $photo"
done

