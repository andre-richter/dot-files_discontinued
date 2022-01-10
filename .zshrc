# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="unfunky"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(rust git docker sudo zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Keybindings
bindkey '^H' backward-kill-word # CTRL-Backspace

# Completion for ..<TAB>
zstyle ':completion:*' special-dirs true

# Syntax highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout

ZSH_HIGHLIGHT_STYLES[path]=fg=white

ZSH_HIGHLIGHT_STYLES[alias]=fg=221,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=221,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=221,bold

ZSH_HIGHLIGHT_STYLES[function]=fg=213,bold

ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=75,bold
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=75,bold

ZSH_HIGHLIGHT_STYLES[comment]=fg=36

ZSH_HIGHLIGHT_STYLES[globbing]=fg=208

ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=70
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=70

# ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
# ZSH_HIGHLIGHT_STYLES[commandseparator]=none
# ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
# ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
# ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
# ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
# ZSH_HIGHLIGHT_STYLES[assign]=none

source ~/repos/dot-files/scripts/dtdiff.zsh
source ~/repos/dot-files/scripts/last_output_tab_list.zsh

function hexdiff {
    if [ $# -eq 2 ]; then
	meld =(hexdump -C $1) =(hexdump -C $2)
    else
	emacs -nw =(hexdump -C $1)
    fi
}

function git-config-gpg-local-github {
    git config --replace-all user.name "Andre Richter"
    git config --replace-all user.email "andre.o.richter@gmail.com"
    git config --replace-all user.signingkey "50E17457"
    git config --replace-all core.editor "emacs"
    git config --replace-all commit.gpgsign "true"
    git config --replace-all gpg.program "gpg2"
    git config --replace-all push.default "simple"
}

function git-config-local-github {
    git config --remove-section user
    git config --remove-section commit
    git config --remove-section gpg

    git config --replace-all user.name "Andre Richter"
    git config --replace-all user.email "andre.o.richter@gmail.com"
    git config --replace-all core.editor "emacs"
    git config --replace-all push.default "simple"
}

# Try to launch tmux per default over ssh
function sshtmux() {/usr/bin/ssh -t $@ "tmux new || zsh || bash";}

# Scratch ramdisk
RAMDISKDIR="/tmp/ramdisk"

function mkscratch {
    if [ ! -d "$RAMDISKDIR" ]; then
	mkdir "$RAMDISKDIR"
	sudo mount -t tmpfs -o size=16g tmpfs "$RAMDISKDIR"
    else
	echo "$RAMDISKDIR already exists!"
    fi
}

function delscratch {
    if [ -d "$RAMDISKDIR" ]; then
	sudo umount "$RAMDISKDIR"
	rmdir "$RAMDISKDIR"
    else
	echo "$RAMDISKDIR doesn't exist!"
    fi
}

function cat {
    if [ -x "$(command -v bat)" ]; then
        bat -p $@
    else
        /usr/bin/cat $@
    fi
}

# Random aliases
alias ll='ls -alFh'
alias lll='ls -lFh'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias e='exit'
alias emacs='emacs -nw'

# Docker aliases
alias dk='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
alias buildpack='docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb --net=host -v `pwd`:/data -w /data buildpack-deps /bin/bash'
alias grok='docker run -it -v $PWD:/src -p 8080:8080 -p 2222:22 opengrok/docker:latest'

# Kill current tmux session
alias tk='echo $TMUX | cut -d, -f3 | xargs -l1 tmux kill-session -t'

# ripgrep
alias rgi='rg -i --hidden'

# Git
alias gs='git status'

# GPG
if [ -f ~/repos/dot-files/.use_gpgrc ]; then
    source ~/repos/dot-files/.gpgrc
fi

# This one is generated by https://www.rustup.rs/
if [ -f ~/.zprofile ]; then
    source ~/.zprofile
fi

# If an additional profile is needed, install a symbolic link
# that gets followed
if [ -f ~/repos/dot-files/.additional_profile ]; then
    source ~/repos/dot-files/.additional_profile
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f /opt/rust-raspberrypi-OS-tutorials/devtool_completion.bash ] && source /opt/rust-raspberrypi-OS-tutorials/devtool_completion.bash

eval "$(starship init zsh)"
