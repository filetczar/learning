#!/bin/bash
# Create a script that checks for a file or directory and returns what type of path it is as an exit status
# file: 1
# directory: 2
# else: 3

read -p "Enter path here: " PATH 

if [ -f "$PATH" ]
then
   exit 1
   echo $?
elif [ -d "$PATH" ]
then 
   exit 2
   echo $?
else
   exit 3 
   echo $?	
fi
 
