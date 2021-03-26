#!/bin/bash

dir=$1

if [ ! -d $dir ]; then
    echo "Given directory doesn't exist."
    exit 1
fi

logs=$(ls $dir | grep -E "localhost_access_log.[[:digit:]]{4}-02.*")

if [ -z "${logs}" ]; then 
    echo "Directory doesn't contain required files."
    exit 1
fi

for log in $logs
do
    echo $log | sed -r 's/.*\.([[:digit:]]{4})-([[:digit:]]{2})-([[:digit:]]{2}).*/datum: \3-\2-\1/'
    echo "--------------------------------------------------"
    cat $log | cut -d '"' -f 2 | sort | uniq -c | sort -rn | sed -r 's/\s*([[:digit:]]*)\s(.*)/\1 : \2/'
done