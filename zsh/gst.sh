#!/usr/bin/zsh

function getout {
	echo -n $fg_no_bold[white]
	echo -n $reset_color
	exit 0
}

autoload -Uz colors && colors
directory=$(pwd)
repo=$(echo $directory | rev | cut -d'/' -f1 | rev)

[ ! -d .git ] && echo -n "$fg[blue]$repo" && getout

gitstatus=$(git status --porcelain | cut -d' ' -f2)

[ -z $gitstatus ] && echo -n "$fg_bold[cyan]$repo" && getout
[ $gitstatus = "D" ] && echo -n "$f_bold[red]-$repo" && getout
[ $gitstatus = "M" ] && echo -n "$fg_bold[yellow]·$repo" && getout
echo -n "$fg_bold[green]$repo" && getout

echo "WTF"
