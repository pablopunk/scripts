#!/bin/bash
#
# Copyright 2016 Pablo Varela
# 
# This script returns the current directory name
# If it's a git repo, it will return the branch
# and the status symbols
#

bold=$(tput bold)
normal=$(tput sgr0)

# Symbols
cleanSymbol="\033[39m✓"   # foreground
changedSymbol="\033[33m•" # yellow
newSymbol="\033[34m+"     # blue
delSymbol="\033[31m⨯"     # red

repo=${PWD##*/}

[ ! -d .git ] && echo -en "$bold$repo$normal" && exit 0

gitstatus=($(git status --porcelain | cut -d' ' -f2)) # array of lines
branch="$(git symbolic-ref HEAD 2>/dev/null)" || branch="unnamed branch"
branch=${branch##refs/heads/}

clean=0; del=0; changed=0; new=0;

for line in $gitstatus; do
	if [ "$line" = "D" ]; then
		del=1
	elif [ "$line" = "M" ]; then
		changed=1
	else
		new=1
	fi
done

[ -z "$line" ] && clean=1

[ $clean -eq 1 ]   && branch="$branch$cleanSymbol"
[ $del -eq 1 ]     && branch="$branch$delSymbol"
[ $new -eq 1 ]     && branch="$branch$newSymbol"
[ $changed -eq 1 ] && branch="$branch$changedSymbol"

# output
echo -en "$bold$repo$normal at $bold$branch$normal"
