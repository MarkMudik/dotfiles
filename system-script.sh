#!/bin/bash

sudo pacman -Syu --needed --noconfirm bash-completion
sudo pacman -S --needed --noconfirm git
sudo pacman -S --needed --noconfirm base-devel
sudo pacman -S --needed --noconfirm ttf-meslo-nerd
sudo pacman -S --needed --noconfirm zoxide
sudo pacman -S --needed --noconfirm fd
sudo pacman -S --needed --noconfirm ripgrep
sudo pacman -S --needed --noconfirm steam
sudo pacman -S --needed --noconfirm qbittorrent
sudo pacman -S --needed --noconfirm wine
sudo pacman -S --needed --noconfirm winetricks
sudo pacman -S --needed --noconfirm vulkan-tools
sudo pacman -S --needed --noconfirm vulkan-icd-loader
sudo pacman -S --needed --noconfirm calibre
sudo pacman -S --needed --noconfirm neovim
sudo pacman -S --needed --noconfirm tree
sudo pacman -S --needed --noconfirm stow
sudo pacman -S --needed --noconfirm openvpn
sudo pacman -S --needed --noconfirm networkmanager-openvpn

yay -S --needed --noconfirm vscode-langservers-extracted
yay -S --needed --noconfirm stremio
yay -S --needed --noconfirm phinger-cursors

# Hyprland
sudo pacman -S --needed --noconfirm swaync
sudo pacman -S --needed --noconfirm wireplumber
sudo pacman -S --needed --noconfirm xdg-desktop-portal-hyprland
sudo pacman -S --needed --noconfirm hyprpolkitagent
sudo pacman -S --needed --noconfirm qt5-wayland
sudo pacman -S --needed --noconfirm qt6-wayland
sudo pacman -S --needed --noconfirm waybar
sudo pacman -S --needed --noconfirm hyprpaper
sudo pacman -S --needed --noconfirm rofi
sudo pacman -S --needed --noconfirm hyprpicker
sudo pacman -S --needed --noconfirm wl-clipboard
sudo pacman -S --needed --noconfirm cliphist
sudo pacman -S --needed --noconfirm network-manager-applet
sudo pacman -S --needed --noconfirm playerctl
sudo pacman -S --needed --noconfirm hyprcursor
sudo pacman -S --needed --noconfirm pulseaudio pulseaudio-alse pavucontrol
sudo pacman -S --needed --noconfirm 7zip
sudo pacman -S --needed --noconfirm obsidian

sudo pacman -S --needed --noconfirm yazi

sudo pacman -S --needed --noconfirm gnome
sudo pacman -S --needed --noconfirm gnome-tweaks


sudo pacman -S --needed --noconfirm firefox
yay -S --needed --noconfirm localsend-bin

sudo pacman -S --needed --noconfirm clang

sudo pacman -S --needed --noconfirm gnupg

sudo pacman -S --needed --noconfirm neovide
