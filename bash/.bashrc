#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias emptyTrash='rm -rf ~/.local/share/Trash/{files,info}/*'

eval "$(zoxide init bash)"

export PATH="$HOME/dotfiles/scripts:$PATH"
