#!/bin/bash

if [ $# -ne 2 ]; then
    echo "2 directory paths must be entered."
    exit 1
fi

if [ ! -d $1 ] || [ ! -d $2 ]; then
    echo "Specified directory doesn't exist."
    exit 1
fi

