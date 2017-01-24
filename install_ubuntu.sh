#!/usr/bin/env bash

ln -s ~/repos/dot-files/.bashrc ~/.bash_aliases
cp .gitconfig gpg.conf ~/
mkdir ~/.gnupg/
cp gpg-agent.conf ~/.gnupg/gpg-agent.conf

sudo apt-get install -y gnupg2 gnupg-agent scdaemon pcscd

gpg2 --recv-key 0x20575b0850e17457
