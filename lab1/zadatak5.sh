#!/bin/bash

echo "Arguments: $1 $2"

find $1 -name "$2" | xargs wc -l | grep "total" | sed -r 's/\s*([[:digit:]]+).*/\1/'
