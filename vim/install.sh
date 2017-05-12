#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -s $DIR $HOME/.vim
ln -s $DIR/vimrc $HOME/.vimrc

if hash nvim 2>/dev/null; then
	mkdir -p $HOME/.config
	ln -s $HOME/.vim $HOME/.config/nvim
	ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim
fi

