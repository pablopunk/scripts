#!/bin/bash
# 
# Copyright (c) 2016 Pablo Varela
#
# Usage: ./download_subtitles.sh /path/to/videos/folder

if [ ! $# -eq 1 ]; then
  echo "Usage: ./download_subtitles.sh /path/to/videos/folder"
  exit 1
fi

root="$1"
lang="es"

subliminal download $root -l $lang



