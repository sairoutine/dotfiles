#!/bin/sh

ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile

if [ ! -d ~/.vim/bundle/neobundle.vim ]; then
	mkdir -p ~/.vim/bundle
	git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
fi
