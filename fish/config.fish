# ~/.config/fish/config.fish

# Define custom prompt
function fish_prompt
    echo -n '['(prompt_pwd)']$ '
end

if status is-interactive
    # Disable fish greeting
    set fish_greeting

    # Aliases
    alias cat='bat'
    alias ls='eza --icons --time-style=long-iso --group-directories-first'
    alias vim='nvim'

    # zoxide and other initializations
    zoxide init fish --cmd cd | source
    # starship init fish | source

    # Editor variables (universal or global)
    set -Ux EDITOR nvim
    set -Ux VISUAL nvim
end
