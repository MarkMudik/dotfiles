# ~/.config/fish/config.fish

# Custom prompt (mimics your Zsh prompt)
function fish_prompt
    echo -n '['(prompt_pwd)']$ '
end

if status is-interactive
    # Disable fish greeting
    set fish_greeting

    # === Key Bindings ===
    # Use Vi mode
    fish_vi_key_bindings

    # Emacs-style movement keys in insert mode
    bind -M insert \ca beginning-of-line
    bind -M insert \ce end-of-line
    bind -M insert \cr history-search-backward
    bind -M insert \cs history-search-forward
    bind -M insert \cy accept-autosuggestion

    # Make backspace work normally
    bind -M insert \x7f backward-delete-char
    bind -M insert \e\[3~ delete-char

    # Ctrl+P/N to search backward/forward like Zsh
    bind -M insert \cp history-search-backward
    bind -M insert \cn history-search-forward

    # === Aliases ===
    alias cat='bat'
    alias ls='eza --icons --time-style=long-iso --group-directories-first'
    alias vim='nvim'
    alias grep='grep --color=auto'
    alias steam='env STEAM_FORCE_XWAYLAND=1 steam'

    # Git Aliases
    alias gst='git status'
    alias s='git status'
    alias gaa='git add -A'
    alias gc='git commit'
    alias gcm='git checkout main'
    alias gd='git diff'
    alias gdc='git diff --cached'
    alias co='git checkout'
    alias up='git push'
    alias upf='git push --force'
    alias pu='git pull'
    alias pur='git pull --rebase'
    alias fe='git fetch'
    alias re='git rebase'
    alias lr='git l -30'
    alias cdr='cd (git rev-parse --show-toplevel)'
    alias hs='git rev-parse --short HEAD'
    alias hm='git log --format=%B -n 1 HEAD'

    # Fuzzy branch checkout (fo)
    function fo
        git branch --no-color --sort=-committerdate --format='%(refname:short)' | fzf --header='git checkout' | read branch && git checkout $branch
    end

    # Fuzzy PR checkout (po)
    function po
        gh pr list --author "@me" | fzf --header='checkout PR' | awk '{print $(NF-5)}' | read pr && git checkout $pr
    end

    # mkdir and cd
    function mkdircd
        mkdir -p $argv[1]; and cd $argv[1]
    end

    # === Editor ===
    set -Ux EDITOR nvim
    set -Ux VISUAL nvim

    # === zoxide ===
    zoxide init fish --cmd cd | source

    # === fzf ===
    fzf --fish | source

    # === Starship (optional) ===
    # starship init fish | source
end
