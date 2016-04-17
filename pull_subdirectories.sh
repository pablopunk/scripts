#!/bin/bash
#
# Copyright (c) Pablo Varela 2016
# Original author of the git code and code
# explanation can be found in the next link:
# http://stackoverflow.com/questions/3497123/run-git-pull-over-all-subdirectories
#
# This script just navigates into 
# each subdirectory of current folder
# and makes a 'git pull'
#

branch="master"

function makepull {
  find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin $branch \;
}

function maketest {
  find . -type d -depth 1 -exec echo git --git-dir={}/.git --work-tree=$PWD/{} status \;
}

numargs=$#
if [ $numargs -eq 0 ]; then # DEFAULT: executes with no stderr
  exec 2> /dev/null
fi

for ((i=0 ; i < numargs ; i++)); do
  if [ "$1" = "-t" ]; then   # TEST MODE: just shows the
                             # commands that would be executed
    maketest
  elif [ "$1" = "-v" ]; then # VERBOSE
    echo "-- verbose mode --"; exec 2> /dev/null
  elif [ "$1" = "-b" ] && [ ! -z "$2" ]; then # select default branch
    branch=$2; shift; let i=$i+1 # jump arg
  else
    echo "Usage: ./pull_subdirectories.sh [-v] [-t] [-b branch_name]"
    exit 1
  fi
  shift
done

makepull

