#!/bin/bash

touch ~/.bashrc_local
touch ~/.bash_aliases_local
touch ~/.bash_functions_local

# ln -sv ~/dotfiles/.bashrc ~

ln -sv ~/dotfiles/.bash_aliases ~
ln -sv ~/dotfiles/.bash_functions ~

ln -sv ~/dotfiles/.gitignore_global ~
ln -sv ~/dotfiles/.tmux.conf ~

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Enter 'tmux' and CTRL+b SHIFT+i to install plugins."
echo "Source dotfiles in ~/.bashrc according to need."

git config --global core.excludesfile ~/.gitignore_global
git config --global core.editor "nano"
git config --global alias.s status

