#!/bin/sh

# usage: sudo dotfilesLink.sh

# 現在のディレクトリ
DIR=$(cd $(dirname $0); pwd)

ln -snf ~/dotfiles/.vimrc ~/.vimrc
ln -snf ~/dotfiles/.vim ~/.vim
ln -snf ~/dotfiles/.gitconfig ~/.gitconfig
ln -snf ~/dotfiles/.bash_profile ~/.bash_profile
ln -snf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -snf ~/dotfiles/.ssh/config ~/.ssh/config
