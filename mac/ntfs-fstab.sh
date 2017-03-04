#!/bin/bash

if [ ! $# -eq 1 ]; then
  echo "Usage: ./ntfs-fstab.sh <disk-label>"
  exit 1
fi

echo "LABEL=$1 none ntfs rw,auto,nobrowse" | sudo tee /etc/fstab
