#!/usr/bin/env bash

ln -s ~/repos/dot-files/.bashrc ~/.bash_aliases
cp .gitconfig gpg-agent.conf gpg.conf ~/

gpg2 --recv-key 0x20575b0850e17457
