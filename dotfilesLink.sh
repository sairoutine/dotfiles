#!/bin/sh

# vim7.4のインストール
# tmuxのインストール

ln -snf ~/dotfiles/.vimrc ~/.vimrc
ln -snf ~/dotfiles/.vim ~/.vim
ln -snf ~/dotfiles/.bash_profile ~/.bash_profile
ln -snf ~/dotfiles/.tmux.conf ~/.tmux.conf

# Neobundle の設定
if [ ! -d ~/.vim/bundle/neobundle.vim ]; then
	mkdir -p ~/.vim/bundle
	git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
fi

# peco のダウンロード
wget https://github.com/peco/peco/releases/download/v0.3.2/peco_linux_amd64.tar.gz
# 展開
tar -xzf peco_linux_amd64.tar.gz
# $PATHのディレクトリに移動させる
mv ./peco_linux_amd64/peco /usr/local/bin/

rm peco_linux_amd64.tar.gz
rm -rf ./peco_linux_amd64

# ag
rpm -ivh http://swiftsignal.com/packages/centos/6/x86_64/the-silver-searcher-0.13.1-1.el6.x86_64.rpm

# vim7.4
yum install -y gcc
yum install -y ncurses-devel


wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar xjf vim-7.4.tar.bz2
cd vim74

./configure \
 --enable-multibyte \
 --with-features=huge \
 --enable-luainterp \
 --enable-perlinterp \
 --enable-pythoninterp \
 --with-python-config-dir=/usr/lib64/python2.6/config \
 --enable-rubyinterp \
 --with-ruby-command=/usr/bin/ruby \
 --prefix=$HOME/local

make
make install

# 完了
echo "done!"
