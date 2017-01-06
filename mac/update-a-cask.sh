#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: ./update-a-cask.sh <cask-name> <github-user>"
  exit 0
fi

# install tools if needed
brew install vitorgalvao/tiny-scripts/cask-repair
brew install hub

# fork cask
cd "$(brew --repository)/Library/Taps/caskroom/homebrew-cask/Casks"
git config --local hub.protocol https
hub fork

# update cask
cd "$(brew --repository)/Library/Taps/caskroom/homebrew-cask/Casks"
cask-repair --pull origin --push $2 $1
