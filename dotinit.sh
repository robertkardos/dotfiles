#!/bin/bash

echo "0. Source the entry point in ~/.bash_profile:

if [ -n "$BASH_VERSION" ]; then
    # INSERT THIS PART
    # include dotfiles repo entry point
    if [ -f "$HOME/dotfiles/.bashrc_synced" ]; then
	. "$HOME/dotfiles/.bashrc_synced"
    fi
    # / INSERT THIS PART

    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

Insert before the regular .bashrc to make local overrides possible.


"

# GIT STUFF
if [ -f "$HOME/.gitignore_global" ]; then
	echo ".gitignore_global not linked up because it already exists, MERGE MANUALLY"
else
    ln -sv ~/dotfiles/.gitignore_global ~
fi

git config --global core.excludesfile ~/.gitignore_global
git config --global core.editor "nano"
git config --global alias.s status
git config --global alias.can "commit --amend --no-edit"
# / GIT STUFF

# TMUX STUFF
# create an empty ~/.tmux.conf if it does not exist
if [ ! -f "$HOME/.tmux.conf" ]; then
    echo "$HOME/.tmux.conf did not exist, created"
    touch "$HOME/.tmux.conf"
fi

# source the synchronized tmux config
if ! grep -q "source-file ~/dotfiles/.tmux.conf_synced" "$HOME/.tmux.conf"
then
    echo "" >> "$HOME/.tmux.conf"
    echo "# content before include will be overridden by the common settings" >> "$HOME/.tmux.conf"
    echo "source-file ~/dotfiles/.tmux.conf_synced" >> "$HOME/.tmux.conf"
fi

if [ ! -f "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "1. Enter 'tmux' and CTRL+b SHIFT+i to install plugins."
# / TMUX STUFF

if [ -f "$HOME/.inputrc" ]; then
	echo ".inputrc not linked up because it already existsc, MERGE MANUALLY"
else
    ln -sv ~/dotfiles/.inputrc ~
fi

if [ -f "$HOME/.prompt" ]; then
	echo ".prompt not linked up because it already exists, MERGE MANUALLY"
else
    ln -sv ~/dotfiles/.prompt ~
fi

if [ -f "$HOME/.config/nvim/lua/init_synced.lua" ]; then
	echo ".init_synced.lua not linked up because it already exists, MERGE MANUALLY"
else
    ln -sv ~/dotfiles/init_synced.lua ~/.config/nvim/lua/init_synced.lua
fi