#!/bin/bash
# Prompt the user for a file path and returns what type of file path is 
c_dir="$(pwd)"
echo "Current directory is ${c_dir}"
read -p "Enter a file path: " file 

file ${file}
