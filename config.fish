if status is-interactive
    set fish_greeting

    # Commands to run in interactive sessions can go here
    alias cat='bat'
    alias ls='eza -l --icons --time-style=long-iso --group-directories-first'
    zoxide init fish --cmd cd | source
    starship init fish | source

    set -Ux EDITOR nvim
    set -Ux VISUAL nvim
end
