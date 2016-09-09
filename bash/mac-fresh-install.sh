#!/bin/bash
# Copyright Pablo Varela 2016
# TODO: test this script in an actual fresh install of the lastest OS X
echo " !! WARNING: this script hasn't been tested yet. Use it at your own risk"

# args
if [ $# -eq 0 ]; then
  exec 2> /dev/null
elif [ "$1" = "-v" ]; then
  echo " -- Verbose mode --"
else
  echo " Usage: ./fresh-install.sh [-v]"
  exit 1
fi

# checks for command line tools
gcc -v
if [ $? -ne 0 ]; then
  echo " !! Command line tools are not installed."
  echo " -> Installing..."
  xcode-select --install
  if [ $? -ne 0 ]; then
    echo " ** Error installing command line tools :("
    echo "    if they are installed please Agree the Xcode license opening Xcode.app"
    exit 2
  fi
fi
echo " -> Command line tools are installed"

# installs oh-my-zsh
echo " -> Installing oh-my-sh.."; sleep 1
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# installs homebrew
echo " -> Installing homebrew.."; sleep 1
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# installs wget,vim
echo " -> Installing some utilities.."; sleep 1
brew install vim wget

# installs powerline fonts
git clone https://github.com/powerline/fonts /tmp/fonts
/tmp/fonts/install.sh

# downloads vimrc/zshrc and terminal theme
echo " -> Installing some configurations.."; sleep 1
sh -c "wget https://raw.githubusercontent.com/pablopunk/mac-config/master/vim/vimrc -O ~/.vimrc"
sh -c "wget https://raw.githubusercontent.com/pablopunk/mac-config/master/zsh/zshrc -O ~/.zshrc"
sh -c "wget https://raw.githubusercontent.com/pablopunk/mac-config/master/terminal-themes/Midnight.terminal -O Midnight.terminal"
sh -c "wget https://raw.githubusercontent.com/pablopunk/mac-config/master/terminal-themes/Daylight.terminal -O Daylight.terminal"
open Midnight.terminal && sleep 1 && rm Midnight.terminal
open Daylight.terminal && sleep 1 && rm Daylight.terminal
