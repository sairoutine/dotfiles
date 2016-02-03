#!/bin/sh

# usage: sudo dotfilesLink.sh

# 現在のディレクトリ
DIR=$(cd $(dirname $0); pwd)

ln -snf ~/dotfiles/.vimrc ~/.vimrc
ln -snf ~/dotfiles/.vim ~/.vim
ln -snf ~/dotfiles/.gitconfig ~/.gitconfig
ln -snf ~/dotfiles/.zshrc ~/.zshrc
ln -snf ~/dotfiles/.npmrc ~/.npmrc
ln -snf ~/dotfiles/.jshintrc ~/.jshintrc
ln -snf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -snf ~/dotfiles/.ssh/config ~/.ssh/config
chmod 0600 ~/.ssh/config
