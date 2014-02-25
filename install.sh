#!/bin/sh
if [ $# -eq 0 ]; then
  CONFIG_ROOT=`pwd`
else
  CONFIG_ROOT=$1
fi

cd $CONFIG_ROOT
git submodule init
git submodule update
cd -
cd ~
function link()
{
  if [ -e $HOME/$1 ] || [ -h $HOME/$1 ]; then
    mv $1 $1.old
  fi
  ln -s $CONFIG_ROOT/$2/$1
}
link .bash_profile bash
link .bash bash
link .vimrc vim
link .vim vim
link .gitconfig .
link scripts .
cd -
