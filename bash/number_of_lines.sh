#!/bin/bash
# Copyright (c) 2016 Pablo Varela
#
# Prints how many lines the current directory files have
#

if [ $# -lt 1 ]; then
  echo "Usage: ./script.sh path [optional: --exclude <regexp>]"
	echo "Example: ./number_of_lines.sh . -e \"*.txt\|main\|*.m\|*.dSYM\""
  exit 1
fi 

dir="." # default dir
default_exclude="*.txt\|main\|*.m\|*.dSYM" # default excluded files (separate regexp with \|)
exclude="$default_exclude"

# args
for ((i=0 ; i < $# ; i++)); do
	if [ "$1" = "-e" ] || [ "$1" = "--exclude" ] ; then
		if [ -z $2 ]; then
			echo "Option -e|--exclude needs an argument"; exit 1;
		else
			exclude="$2"; shift; let i=$i+1 # jump arg
		fi
	elif [ -d $1 ] ; then # if directory exists
		dir=$1
	else
		echo "Invalid argument: Directoy '$1' not found"; exit 1
	fi
	shift
done

cd $dir
ls -1 | grep -v $exclude | xargs wc -l | xargs echo | rev | cut -d' ' -f2 | rev

# ls -1 (list directory files, one line each)
# grep -v $exclude (exclude all files you don't want)
# xargs wc -l (count each file lines and total lines)
# xargs echo (print 'wc' output in one line)
# rev (reverse that output)
# cut -d' ' -f2 (take the second word, which is the total lines)

