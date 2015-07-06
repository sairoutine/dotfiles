#!/bin/sh

# usage: sudo dotfilesLink.sh

# 現在のディレクトリ
DIR=$(cd $(dirname $0); pwd)

ln -snf ~/dotfiles/.vimrc ~/.vimrc
ln -snf ~/dotfiles/.vim ~/.vim
ln -snf ~/dotfiles/.bash_profile ~/.bash_profile
ln -snf ~/dotfiles/.tmux.conf ~/.tmux.conf

# vim pluginの設定
if [ ! -d ~/.vim/bundle/neobundle.vim ]; then
	mkdir -p ~/.vim/bundle

	# NeoBundle のインストール
	git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim

	# vimprocのインストール
	git clone https://github.com/Shougo/vimproc.vim.git ~/.vim/bundle/vimproc.vim
	cd ~/.vim/bundle/vimproc.vim

	# vimprocのmake
	make

	# ホームに戻る
	cd $DIR
fi

# peco のインストール
if [ ! -f /usr/local/bin/peco ]; then
	# peco のダウンロード
	wget https://github.com/peco/peco/releases/download/v0.3.2/peco_linux_amd64.tar.gz
	# 展開
	tar -xzf peco_linux_amd64.tar.gz
	# $PATHのディレクトリに移動させる
	mv ./peco_linux_amd64/peco /usr/local/bin/

	# あとしまつ
	rm peco_linux_amd64.tar.gz
	rm -rf ./peco_linux_amd64
fi

# ag
rpm -ivh http://swiftsignal.com/packages/centos/6/x86_64/the-silver-searcher-0.13.1-1.el6.x86_64.rpm

# vim7.4
yum install -y gcc
yum install -y ncurses-devel


wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar xjf vim-7.4.tar.bz2
cd vim74
make
make install

# あとしまつ
rm vim-7.4.tar.bz2
rm -rf vim74

cd $DIR

# 完了
echo "done!"
