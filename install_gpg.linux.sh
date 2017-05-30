#!/usr/bin/env bash

./set_perms.sh

mkdir ~/.gnupg/
chmod 700 ~/.gnupg/
ln -s ~/repos/dot-files/gpg.conf ~/.gnupg/gpg.conf
ln -s ~/repos/dot-files/gpg-agent.conf ~/.gnupg/gpg-agent.conf

sudo apt install -y gnupg2 gnupg-agent pinentry-curses scdaemon pcscd

gpg2 --recv-key 0x20575b0850e17457