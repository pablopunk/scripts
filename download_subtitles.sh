#!/bin/bash
# 
# Copyright (c) 2016 Pablo Varela
#

root="/home/pi/mnt/toshiba/torrents"
lang="es"

function download {
  subliminal download ./* -l $lang
}

cd $root

for dir in ./*; do # for each subdirectory (depth=1)
  cd $dir
  download # try download with all files
  cd ..
done


