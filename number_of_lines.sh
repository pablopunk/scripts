#!/bin/bash
# Copyright (c) 2016 Pablo Varela
#
# Prints how many lines the current directory files have
#

if [ ! $# -eq 1 ]; then
  echo "Usage ./script.sh path"
  exit 1
fi 

dir="$1" # path
if [ ! -d $dir ]; then
  echo "$dir does not exist"
  exit 1
fi


exclude="*.txt\|main\|*.m\|*.dSYM\|.*" # put here every file or regex you want NOT to be counted. Separate files or regex with \|

cd $dir
ls -1 | grep -v "$exclude" | xargs wc -l | xargs echo | rev | cut -d' ' -f2

# ls -1 (list directory files, one line each)
# grep -v $exclude (exclude all files you don't want)
# xargs wc -l (count each file lines and total lines)
# xargs echo (print 'wc' output in one line)
# rev (reverse that output)
# cut -d' ' -f2 (take the second word, which is the total lines)

