#!/bin/bash

VIMBASE=`pwd`
LINKS="$HOME/.config/nvim"
BUNDLE_BASE=$VIMBASE/bundle
VIMBIN=$VIMBASE
CQUERY_REPO="https://github.com/MaskRay/ccls"
LANG_SERVER_BASE="$VIMBASE/lang-server"
LLVM_VER="7.0.1"
LLVM_NAME="clang+llvm-${LLVM_VER}-x86_64-linux-gnu-ubuntu-16.04"

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

# install ccls
echo "Installing ccls requires downloading and compiling latest libclang which may take a while"
## clone ccls
if [ ! -e $LANG_SERVER_BASE/ccls ]; then
  git clone --recursive $CQUERY_REPO $LANG_SERVER_BASE/ccls
else
  echo "ccls already installed"
fi

if [ ! -e $LANG_SERVER_BASE/$LLVM_NAME.tar.xz ]; then
  cd $LANG_SERVER_BASE
  curl -OL "http://releases.llvm.org/${LLVM_VER}/${LLVM_NAME}.tar.xz"
  tar -xf ${LLVM_NAME}.tar.xz
  cd $VIMBASE
else
  echo "llvm already downloaded"
fi
## build ccls
cd $LANG_SERVER_BASE/ccls
rm -rf $LANG_SERVER_BASE/ccls/Release
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=../${LLVM_NAME}
cmake --build Release
cd $VIMBASE

# done
echo "done"

