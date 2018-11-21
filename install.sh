#!/bin/bash

VIMBASE=`pwd`
LINKS="$HOME/.config/nvim"
BUNDLE_BASE=$VIMBASE/bundle
VIMBIN=$VIMBASE
CQUERY_REPO="https://github.com/cquery-project/cquery"
LANG_SERVER_BASE="$VIMBASE/lang-server"

# check dir existence
if [ ! -e $HOME/.config ]; then
  mkdir $HOME/.config
fi

# create links
for link in $LINKS; do
  if [ -L $link -o -e $link ]; then
    rm -r $link
  fi
done

ln -s $VIMBASE ${HOME}/.config/nvim

# install dependencies
echo "install dependencies"
pip3 1>/dev/null 2>/dev/null && pip3 install neovim
if [ $? -ne 0 ]; then
  echo "python-pip or python3-pip not installed, exit"
  exit
fi
echo "install dependecies done"

# install plugins
vim -u $VIMBASE/init-bundle.vim +"PlugInstall!" +"PlugClean!" +"qall"
if [ $? -ne 0 ]; then
  echo "installing plugins failed"
  exit 1
fi
echo "all plugins cloned"

# install cquery
echo "Installing cquery requires downloading and compiling latest libclang which may take a while"
## clone cquery
if [ ! -e $LANG_SERVER_BASE/cquery ]; then
  git clone --recursive $CQUERY_REPO $LANG_SERVER_BASE/cquery
else
  echo "cquery already installed"
fi
## build cquery
if [ -e $LANG_SERVER_BASE/cquery ]; then
  rm -rf $LANG_SERVER_BASE/cquery/build
  mkdir $LANG_SERVER_BASE/cquery/build
  cd $LANG_SERVER_BASE/cquery/build
  cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
  cmake --build .
  cd $VIMBASE
fi

# done
echo "done"

