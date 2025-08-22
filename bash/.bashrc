#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend

alias vim="nvim"
export EDITOR="nvim"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias emptyTrash='rm -rf ~/.local/share/Trash/{files,info}/*'

# eval "$(zoxide init bash --cmd cd)"

# Makes denote script in ~/dotfiles/scripts/denote executable anywhere
export PATH="$HOME/projects/git/dotfiles/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
