#!/usr/bin/env bash

sudo apt install fonts-powerline zsh curl
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

rm -rf ~/.zshrc
ln -s ~/repos/dot-files/.zshrc ~/.zshrc

ln -s ~/repos/dot-files/.tmux.conf.linux ~/.tmux.conf

for i in "$@"
do
    case $i in
	--gpg)
            bash install_gpg.linux.sh
	    touch .use_gpgrc
	    shift
	    ;;
	*)
	    ;;
    esac
done

if [ -e ~/.gitconfig ]; then
    echo "Skipping .gitconfig, file already exists!"
else
    if [ -f ~/repos/dot-files/.use_gpgrc ]; then
	ln -s ~/repos/dot-files/.gitconfig_gpg ~/.gitconfig
    else
	ln -s ~/repos/dot-files/.gitconfig ~/.gitconfig
    fi
fi
