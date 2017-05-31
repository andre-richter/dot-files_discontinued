#!/usr/bin/env bash

#
# Insert needed homebrew taps here
#
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

curl -o ~/.oh-my-zsh/themes/unfunky.zsh-theme https://raw.githubusercontent.com/andre-richter/unfunky-theme/master/unfunky.zsh-theme

rm -rf ~/.zshrc
ln -s ~/repos/dot-files/.zshrc ~/.zshrc

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

# Port this one to zsh:
# ln -s ~/repos/dot-files/.bash_profile.macOS ~/.bash_profile
ln -s ~/repos/dot-files/.inputrc.macOS ~/.inputrc

ln -s ~/repos/dot-files/.gitconfig ~/.gitconfig

for i in "$@"
do
    case $i in
	--gpg)
            bash install_gpg.macOS.sh
	    touch .use_gpgrc
	    shift
	    ;;
	*)
	    ;;
    esac
done
