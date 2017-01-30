#!/usr/bin/env bash

./set_perms.sh

ln -s ~/repos/dot-files/.bash_profile.macOS ~/.bash_profile
ln -s ~/repos/dot-files/.inputrc.macOS ~/.inputrc

ln -s ~/repos/dot-files/.gitconfig ~/.gitconfig

mkdir ~/.gnupg/
chmod 700 ~/.gnupg/
ln -s ~/repos/dot-files/gpg.conf ~/.gnupg/gpg.conf
ln -s ~/repos/dot-files/gpg-agent.conf ~/.gnupg/gpg-agent.conf

brew tap homebrew/versions
brew install gnupg21
brew install pinentry

sudo ln -s /usr/local/bin/pinentry-curses /usr/bin/pinentry-curses

gpg2 --recv-key 0x20575b0850e17457
