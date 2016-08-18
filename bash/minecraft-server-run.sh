#!/bin/bash
#
# Copyright (c) 2016 Pablo Varela
#
# This script allows you to run 
# a minecraft server and keep it
# it up when it falls
# In order to restart the server
# when it fails, you need to have 
# the $running_file

running_file="/home/pi/workspace/minecraft_server/keep-running"
RAM="1024M"

function run {
  java -Xmx$RAM -Xms$RAM -jar /home/pi/workspace/minecraft_server/minecraft_server.jar nogui
}

while [ -f "$running_file" ]; do
  echo "Starting server..."
  run
done

echo "File not found ($running_file). Exiting..."
