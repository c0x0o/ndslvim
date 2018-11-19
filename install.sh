#!/bin/bash

VIMBASE=`pwd`
LINKS="$HOME/.vim $HOME/.vimrc $HOME/.vimrc.bundles"
BUNDLE_BASE=$VIMBASE/bundle
VIMBIN=$VIMBASE
CQUERY_REPO="https://github.com/cquery-project/cquery"

# create links
for link in $LINKS; do
  if [ -e $link ]; then
    rm $link;
  fi
done

ln -s $VIMBASE/vimrc $HOME/.vimrc
ln -s $VIMBASE/vimrc.bundles $HOME/.vimrc.bundles
ln -s $VIMBASE ${HOME}/.vim

# install dependencies
echo "install dependencies"
pip 2>/dev/null && pip install neovim
pip3 1>/dev/null 2>/dev/null && pip3 install neovim
if [ $? -ne 0 ]; then
  echo "python-pip or python3-pip not installed, exit"
  exit
fi
echo "install dependecies done"

# install plugins
vim -u $VIMBASE/vimrc.bundles +"PlugInstall!" +"PlugClean!" +"qall"
if [ $? -ne 0 ]; then
  echo "installing plugins failed"
  exit 1
fi
echo "all plugins cloned"

# install cquery
echo "Installing cquery requires downloading latest llvm which may take a while"
if [ ! -e $BUNDLE_BASE/cquery ]; then
  git clone --recursive $CQUERY_REPO $BUNDLE_BASE/cquery

  if [ $? -eq 0 ]; then
    mkdir $BUNDLE_BASE/cquery/build
    cd $BUNDLE_BASE/cquery/build
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
    cmake --build .
    cd $VIMBASE
    if [ -e $VIMBASE/cquery ]; then
      rm $VIMBASE/cquery;
    fi
    ln -s $BUNDLE_BASE/cquery/build/cquery $VIMBASE/cquery
    echo "cquery installed"
  else
    echo "cquery install failed"
  fi
else
  echo "cquery already installed"
fi

# done
echo "done"

