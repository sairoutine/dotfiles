#!/bin/sh

# usage: sudo dotfilesLink.sh

# 現在のディレクトリ
DIR=$(cd $(dirname $0); pwd)

ln -snf ~/dotfiles/.vimrc ~/.vimrc
mkdir -p ~/.config/nvim; ln -snf ~/dotfiles/.vimrc ~/.config/nvim/init.vim
ln -snf ~/dotfiles/.vim ~/.vim
ln -snf ~/dotfiles/.gitconfig ~/.gitconfig
ln -snf ~/dotfiles/.gitignore ~/.gitignore
ln -snf ~/dotfiles/.zshrc ~/.zshrc
ln -snf ~/dotfiles/.npmrc ~/.npmrc
ln -snf ~/dotfiles/.eslintrc.json ~/.eslintrc.json
ln -snf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -snf ~/dotfiles/.ssh/config ~/.ssh/config
ln -snf ~/dotfiles/.gdbinit ~/.gdbinit
ln -snf ~/dotfiles/.railsrc ~/.railsrc
ln -snf ~/dotfiles/.hyper.js ~/.hyper.js
chmod 0600 ~/.ssh/config
