#!/bin/bash

file_name='vim.rc'

function go_to_script_dir {
  pushd `dirname $0` > /dev/null
  dir=`pwd -P`
  popd > /dev/null
  cd $dir
}

function link_config_file {
  ln -svf ./$file_name ~/.$file_name
}

go_to_script_dir && link_config_file
