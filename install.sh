#!/bin/bash

info() {
  echo "ndslvim: $1"
}
stage-start() {
  echo -n "ndslvim: $1..."
}
stage-end() {
  echo $1
}

install() {

  cd `dirname $0`
  NDSLVIM_BASE=`pwd`
  NDSLVIM_FILES="$HOME/.vim $HOME/.vimrc $HOME/.vimrc.bundles $HOME/.ycm_extra_config.py $HOME/.tern-project"

  rm ~/.viminfo 2>/dev/null

  info "start installing process"

  # backup config
  stage-start "backup your old settings"
  for file in $NDSLVIM_FILES
  do
    if [ -e $file ]
    then
      if [ -L $file ]
      then
	unlink $file
      else
	mv $file `dirname $file`/`basename $file`.old
      fi
    fi
  done
  stage-end "success"

  # deploy base environment
  stage-start "deploy base environment"
  ln -s $NDSLVIM_BASE ~/.vim
  ln -s $NDSLVIM_BASE/ycm_extra_config.py ~/.ycm_extra_config.py
  ln -s $NDSLVIM_BASE/tern-project ~/.tern-project

  # clone plugin
  vim -u $NDSLVIM_BASE/vimrc.bundles +PlugInstall! +PlugClean! +qall

  ln -s $NDSLVIM_BASE/vimrc ~/.vimrc
  ln -s $NDSLVIM_BASE/vimrc.bundles ~/.vimrc.bundles
  stage-end "success"

  # install ycm
  python3 $DNSLVIM_BASE/bundles/YouCompleteMe/install.py --clange-completer $1
}

install $1
