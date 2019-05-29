#!/usr/bin/env bash

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

sudo apt install fonts-powerline zsh curl tmux
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

curl -o ~/.oh-my-zsh/themes/unfunky.zsh-theme https://raw.githubusercontent.com/andre-richter/unfunky-theme/master/unfunky.zsh-theme

rm -rf ~/.zshrc
ln -s ~/repos/dot-files/.zshrc ~/.zshrc
