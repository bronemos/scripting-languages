#!/bin/bash

grep -i -E 'banana|jabuka|jagoda|dinja|lubenica' namirnice.txt

echo 

grep -i -v -E 'banana|jabuka|jagoda|dinja|lubenica' namirnice.txt

find -r -E '[A-Z]{3}[0-9]{6}\b' ~/projekti/

find . -mtime +7 -mtime -14 -ls

kraj=15
for i in $(seq 1 $kraj); do echo -n "$i "; done
for i in {1..$kraj}; do echo -n "$i "; done