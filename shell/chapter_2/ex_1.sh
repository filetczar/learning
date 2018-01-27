#!/bin/sh
# Write a shell script with a 0 exit status 
HOST="google.com"

ping -c 1 $HOST
RETURN_CODE=$?

if [ $RETURN_CODE == "0" ]
then 
   echo "The exit status is 0"
fi 
