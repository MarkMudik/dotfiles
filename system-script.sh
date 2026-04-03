#!/bin/bash

sudo pacman -Syu --needed --noconfirm bash-completion
sudo pacman -S --needed --noconfirm emacs-wayland
sudo pacman -S --needed --noconfirm git
sudo pacman -S --needed --noconfirm less
sudo pacman -S --needed --noconfirm base-devel
sudo pacman -S --needed --noconfirm fd
sudo pacman -S --needed --noconfirm ripgrep
sudo pacman -S --needed --noconfirm qbittorrent
sudo pacman -S --needed --noconfirm vulkan-tools
sudo pacman -S --needed --noconfirm vulkan-icd-loader
sudo pacman -S --needed --noconfirm neovim
sudo pacman -S --needed --noconfirm tree
sudo pacman -S --needed --noconfirm stow
sudo pacman -S --needed --noconfirm openvpn
sudo pacman -S --needed --noconfirm networkmanager-openvpn
sudo pacman -S --needed --noconfirm fzf
sudo pacman -S --needed --noconfirm firefox
sudo pacman -S --needed --noconfirm 7zip
sudo pacman -S --needed --noconfirm obsidian
sudo pacman -S --needed --noconfirm clang
sudo pacman -S --needed --noconfirm gnupg

yay -S --needed --noconfirm stremio
yay -S --needed --noconfirm vscode-langservers-extracted

# for getting manga on kindle
yay -S kcc
yay -S kindlegen
