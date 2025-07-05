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

# for git
alias monsterclean='git clean -fdx -e .jj/'
alias gst='git status'
alias s='git status'
alias gaa='git add -A'
alias gcm='git checkout main'
alias gd='git diff'
alias gdc='git diff --cached'
# [c]heck [o]ut
alias co='git checkout'
# [f]uzzy check[o]ut
fo() {
  git branch --no-color --sort=-committerdate --format='%(refname:short)' | fzf --header 'git checkout' | xargs git checkout
}
# [p]ull request check[o]ut
po() {
  gh pr list --author "@me" | fzf --header 'checkout PR' | awk '{print $(NF-5)}' | xargs git checkout
}
alias up='git push'
alias upf='git push --force'
alias pu='git pull'
alias pur='git pull --rebase'
alias fe='git fetch'
alias re='git rebase'
alias lr='git l -30'
alias cdr='cd $(git rev-parse --show-toplevel)' # cd to git Root
alias hs='git rev-parse --short HEAD'
alias hm='git log --format=%B -n 1 HEAD'


export PATH="$HOME/dotfiles/scripts:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"

### Bash xdg webjump functions ###
g() {
  if [ -z "$*" ]; then
    xdg-open "https://www.google.com"
  else
    xdg-open "https://www.google.com/search?q=$*"
  fi
}

wiki() {
  if [ -z "$*" ]; then
    xdg-open "https://www.wikipedia.org/"
  else
    xdg-open "https://en.wikipedia.org/wiki/Special:Search?search=$*"
  fi
}

chat() {
  if [ -z "$*" ]; then
    xdg-open "https://chatgpt.com/"
  else
      echo "Cant search in chatgpt"
  fi
}

yt() {
  if [ -z "$*" ]; then
    xdg-open "https://www.youtube.com"
  else
    xdg-open "https://www.youtube.com/results?search_query=$*"
  fi
}
######
