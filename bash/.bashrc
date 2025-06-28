#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gs='git status'
alias gc='git commit'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias emptyTrash='rm -rf ~/.local/share/Trash/{files,info}/*'

eval "$(zoxide init bash --cmd cd)"


export PATH="$HOME/dotfiles/scripts:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
