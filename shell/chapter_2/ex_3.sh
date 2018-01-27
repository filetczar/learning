#!/bin/bash

# execute cat /etc/shadow/ with custom exit statuses

cat /etc/shadow/
if [ "$?" -eq "0" ]
then 
 echo "Command Succeeded!"
 exit 0 
else
 echo "Command Did Not Succeed"
 exit 1
fi

