#!/usr/bin/env bash

# Permissions might have been corrupted when downloading these files from git.
chmod 600 gpg-agent.conf gpg.conf

mkdir -p ~/.gnupg/
chmod 700 ~/.gnupg/
ln -s ~/repos/dot-files/gpg.conf ~/.gnupg/gpg.conf
ln -s ~/repos/dot-files/gpg-agent.conf ~/.gnupg/gpg-agent.conf

sudo apt install -y gnupg2 gnupg-agent pinentry-curses scdaemon pcscd

gpg2 --recv-key 0x20575b0850e17457
