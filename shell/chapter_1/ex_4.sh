#!/bin/bash
# See if shadow passwords exists and if I can write to file 
file="/etc/passwd"

if [ -e "$file" ]
then
     echo "Shadow passwords exist."
else 
 echo "Shadow passwords do not exist."
fi

if [ -w "$file" ]
then 
     echo "You can write to $file."
else
     echo "You cannot write to $file."
fi

