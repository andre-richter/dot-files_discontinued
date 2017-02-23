#!/usr/bin/env bash

git clone git://github.com/jimeh/git-aware-prompt.git

./set_perms.sh

ln -s ~/repos/dot-files/.bashrc ~/.bash_aliases

ln -s ~/repos/dot-files/.gitconfig ~/.gitconfig
ln -s ~/repos/dot-files/.tmux.conf.linux ~/.tmux.conf

mkdir ~/.gnupg/
chmod 700 ~/.gnupg/
ln -s ~/repos/dot-files/gpg.conf ~/.gnupg/gpg.conf
ln -s ~/repos/dot-files/gpg-agent.conf ~/.gnupg/gpg-agent.conf

sudo apt-get install -y gnupg2 gnupg-agent pinentry-curses scdaemon pcscd

gpg2 --recv-key 0x20575b0850e17457
