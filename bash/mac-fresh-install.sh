#!/bin/bash
# Copyright Pablo Varela 2016
# TODO: test this script in an actual fresh install of the lastest OS X
echo " !! WARNING: this script hasn't been tested yet. Use it at your own risk"

ld="\x01$(tput bold)\x02"
normal="\x01$(tput sgr0)\x02"
cyan="\x01\033[36m\x02"
green="\x01\033[32m\x02"
step_symbol="↪"

function pr {
  echo -e "$cyan$bold$step_symbol $1$normal"
}

# Install command line tools
pr "Installing command line tools"
xcode-select --install

# Install homebrew

pr "Installing homebrew.."/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install homebrew cask
brew tap caskroom/cask

pr "Installing homebrew cask.."

# Install wget,vim

pr "Installing some utilities.."
brew install vim wget

# Install nodejs

pr "Installing nodejs.."
brew install node

# Install bashy

pr "Installing bashy.."
npm install --global bashy

# Install powerline fonts
pr "Installing powerline fonts"
git clone https://github.com/powerline/fonts /tmp/fonts
/tmp/fonts/install.sh

# Dotfiles
pr "Configuring dotfiles"
git clone https://github.com/pablopunk/dotfiles ~/.dotfiles
~/.dotfiles/install.sh

echo -e "$green$bold ✓ DONE!$normal"
