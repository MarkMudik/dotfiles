#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\W]\$ '

# Aliases
alias cat='bat'
alias ls='eza --icons --time-style=long-iso --group-directories-first'

# Starship initialization
# eval "$(starship init bash)"

# Set default editor
export EDITOR=nvim
export VISUAL=nvim

# Zoxide initialization
eval "$(zoxide init bash --cmd cd)"
