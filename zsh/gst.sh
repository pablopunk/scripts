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
cleanColor="%{$fg_bold[cyan]%}"
changeColor="%{$fg_bold[yellow]%}"
newColor="%{$fg_bold[green]%}"
delColor="%{$fg_bold[red]%}"
# Symbols
cleanSymbol="✓"
changeSymbol="•"
newSymbol="+"
delSymbol="-"

directory=$(pwd)
repo=$(echo $directory | rev | cut -d'/' -f1 | rev)

[ ! -d .git ] && echo -n "%{$fg[blue]%}$repo" && getout

gitstatus=$(git status --porcelain | cut -d' ' -f2)
branch="$(git symbolic-ref HEAD 2>/dev/null)" || branch="(unnamed branch)"
branch=${branch##refs/heads/}

# clean
[ -z $gitstatus ] && echo -n "$cleanColor$repo ($branch$cleanSymbol)" && getout
# deleted
[ $gitstatus = "D" ] && echo -n "$delColor$repo ($branch$delSymbol)" && getout
# modified
[ $gitstatus = "M" ] && echo -n "$changeColor$repo ($branch$changeSymbol)" && getout
# new
echo -n "$newColor$repo ($branch$newSymbol)" && getout
