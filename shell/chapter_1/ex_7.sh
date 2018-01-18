#!/bin/bash
# Make Exercise 6 but instead of prompting the user take a list of arguments 

for file_in in $@
do 
file ${file_in}
done

