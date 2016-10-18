#!/bin/zsh
array=($(ioreg -l | grep Capacity | cut -d' ' -f19))
per=$(( $array[1] * 100 / $array[4]))
echo $per
