#!/bin/sh

ln -snf ~/dotfiles/.vimrc ~/.vimrc
ln -snf ~/dotfiles/.vim ~/.vim
ln -snf ~/dotfiles/.bash_profile ~/.bash_profile
ln -snf ~/dotfiles/.ackrc ~/.ackrc

if [ ! -d ~/.vim/bundle/neobundle.vim ]; then
	mkdir -p ~/.vim/bundle
	git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
fi
echo "done!"
