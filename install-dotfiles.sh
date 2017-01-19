#!/bin/bash

for D in `find dotfiles/ -mindepth 1 -type d`
do
  bash $D/install.sh
done

ln -snvf $PWD/dotfiles ~/.dotfiles

