#!/usr/bin/env zsh
#
# Copyright 2016 Pablo Varela
# 
# This script returns the current directory name
# If it's a git repo, it will return the name but
# with different colors, depending on the status
#
# It's used for the PROMPT variable in zshrc
# EXAMPLE .zshrc:
# 
# setopt PROMPT_SUBST
# autoload -Uz colors && colors
# PROMPT='%{$fg[red]%}(%m) $(gst)> '
#

function getout {
	echo -n %{$fg_no_bold[white]%}
	echo -n %{$reset_color%}
	exit 0
}

autoload -Uz colors && colors
# Colors
cleanColor="%{$fg_bold[green]%}"
changedColor="%{$fg_bold[yellow]%}"
newColor="%{$fg_bold[cyan]%}"
delColor="%{$fg_bold[red]%}"
# Symbols
cleanSymbol="✓"
changedSymbol="•"
newSymbol="+"
delSymbol="-"

directory=$(pwd)
repo=$(echo $directory | rev | cut -d'/' -f1 | rev)

[ ! -d .git ] && echo -n "%{$fg[green]%}$repo" && getout

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

[ $clean -eq 1 ]   && branch="$branch$cleanSymbol"   && echo -n $cleanColor
[ $del -eq 1 ]     && branch="$branch$delSymbol"     && echo -n $delColor
[ $new -eq 1 ]     && branch="$branch$newSymbol"     && echo -n $newColor
[ $changed -eq 1 ] && branch="$branch$changedSymbol" && echo -n $changedColor

# output
echo -n "$repo ($branch)" && getout
