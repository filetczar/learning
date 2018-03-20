#!/bin/bash

DT=$(date '+%Y-%b-%d')

read -p "Enter file extension " EXT 
read -p "Enter file prefix or Press enter for $DT " PREFIX 
if [ -z $PREFIX ]
then 
PREFIX="$DT"
fi
if [ -f *.$EXT ]
then 
for FILE in *.$EXT
do
echo "Renaming ${FILE} to ${PREFIX}-${FILE}"
mv ${FILE} ${PREFIX}-${FILE}
done 
else 
echo "No Files with extension ${EXT}"
fi
exit 0 
