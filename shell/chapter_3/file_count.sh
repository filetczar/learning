#!/bin/bash 

# Make a function that counts all the files in a directory 

file_count() { 
#local num_files=$(ls ${1} | wc -l)
#echo "$num_files"
echo ls ${1} | wc -l 
}
file_count
