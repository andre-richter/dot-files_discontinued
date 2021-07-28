#!/usr/bin/env bash

# tmux config
rm ~/.tmux.conf
ln -s ~/repos/dot-files/.tmux.conf ~/.tmux.conf

# Conditionally install gpg
for i in "$@"
do
    case $i in
	--gpg)
            bash install_gpg.sh
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

# Productivity tools
sudo apt install zsh curl tmux
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
curl -fsSL https://starship.rs/install.sh | bash

cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-autosuggestions.git

rm -rf ~/.zshrc
ln -s ~/repos/dot-files/.zshrc ~/.zshrc

rm -rf ~/.config/starship.toml
ln -s ~/repos/dot-files/starship.toml ~/.config/starship.toml

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Now with GPG installed, switch to SSH remote URL
if [ -f ~/repos/dot-files/.use_gpgrc ]; then
    git remote set-url origin git@github.com:andre-richter/dot-files.git
fi

echo "Now, install Ubuntu Mono Nerd Font Regular, and set it as terminal font; Size 13"
