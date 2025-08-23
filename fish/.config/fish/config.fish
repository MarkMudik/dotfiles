if status is-interactive

set -U fish_greeting

set -Ux HISTSIZE 10000
set -Ux HISTFILESIZE 20000
set -Ux HISTCONTROL ignoredups:erasedups

# Aliases
alias vim="nvim"
set -Ux EDITOR emacsclient

alias ls="ls --color=auto"
alias grep="grep --color=auto"

alias emptyTrash='rm -rf ~/.local/share/Trash/{files,info}/*'

set -U fish_user_paths $HOME/projects/git/dotfiles/scripts $fish_user_paths

end
