#!/bin/bash

# rename all files that end with .jpeg with the date 

dt=$(date '+%d-%b-%y')

for FILE in *.jpeg
do
echo "Renaming $FILE"
mv $FILE $dt-$FILE
done
exit 0   
