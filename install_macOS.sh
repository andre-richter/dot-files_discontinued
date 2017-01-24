#!/usr/bin/env bash

cp .bash_profile.macOS ~/.bash_profile
cp .inputrc.macOS /.inputrc
cp .gitconfig gpg-agent.conf gpg.conf ~/

brew tap homebrew/versions
brew install gnupg21

gpg2 --recv-key 0x20575b0850e17457
