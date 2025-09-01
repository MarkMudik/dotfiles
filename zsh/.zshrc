#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ -o interactive ]] || return

bindkey -e

autoload -Uz compinit promptinit
compinit
promptinit

source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh

# History settings
HISTSIZE=10000
SAVEHIST=20000
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt APPEND_HISTORY

# Editor
export EDITOR="emacsclient"

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Prompt
PS1='[%n@%m %1~]%# '

# Trash alias
alias emptyTrash='rm -rf ~/.local/share/Trash/{files,info}/*'

source <(fzf --zsh)

# Add scripts and local bin to PATH
export PATH="$HOME/projects/git/dotfiles/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# zsh autocomplete and stuff
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
