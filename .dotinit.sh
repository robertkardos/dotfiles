#!/bin/bash

ln -sv ~/dotfiles/.bash_profile ~
ln -sv ~/dotfiles/.bashrc ~
ln -sv ~/dotfiles/.bash_aliases ~
ln -sv ~/dotfiles/.bash_functions ~
ln -sv ~/dotfiles/.prompt ~
ln -sv ~/dotfiles/.inputrc ~

ln -sv ~/dotfiles/.gitignore_global ~

ln -sv ~/dotfiles/.atom ~

ln -sv ~/dotfiles/.vimrc ~

ln -sv ~/dotfiles/.tmux.conf ~

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Enter 'tmux' and CTRL+b SHIFT+i to install plugins."

git config --global core.excludesfile ~/.gitignore_global
