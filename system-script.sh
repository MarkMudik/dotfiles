#!/bin/bash

sudo pacman -Syu --needed --noconfirm bash-completion
sudo pacman -S --needed --noconfirm emacs-wayland
sudo pacman -S --needed --noconfirm git
sudo pacman -S --needed --noconfirm less
sudo pacman -S --needed --noconfirm base-devel
sudo pacman -S --needed --noconfirm ttf-iosevka-nerd
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
sudo pacman -S --needed --noconfirm openvpn-update-systemd-resolved
sudo pacman -S --needed --noconfirm networkmanager-openvpn

yay -S --needed --noconfirm vscode-langservers-extracted
yay -S --needed --noconfirm stremio

# hyprland
sudo pacman -S --needed --noconfirm hyprland
sudo pacman -S --needed --noconfirm swaync
sudo pacman -S --needed --noconfirm wireplumber
sudo pacman -S --needed --noconfirm pipewire-alsa pipewire-jack pipewire-pulse
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
sudo pacman -S --needed --noconfirm pavucontrol
# sudo pacman -S --needed --noconfirm libnewt MAYBE DELETE

sudo pacman -S --needed --noconfirm 7zip
yay -S --needed --noconfirm obsidian

sudo pacman -S --needed --noconfirm clang

sudo pacman -S --needed --noconfirm gnupg

# for vm's
sudo pacman -S --needed --noconfirm qemu-full
sudo pacman -S --needed --noconfirm virt-manager
sudo pacman -S --needed --noconfirm dnsmasq

sudo pacman -S --needed --noconfirm ghostty

yay -S --needed --noconfirm zen-browser-bin

sudo pacman -S --needed --noconfirm dolphin # file manager

sudo pacman -S --needed --noconfirm rclone

sudo pacman -S --needed --noconfirm thunderbird

yay -S zotero-bin

sudo pacman -S --needed --noconfirm grim
sudo pacman -S --needed --noconfirm slurp

sudo pacman -S --needed --noconfirm fzf

sudo pacman -S python-pip

sudo pacman -S fish

sudo pacman -S noto-fonts

# For school
yay -S logisim

# For emacs export to latex
sudo pacman -S texlive-latex
sudo pacman -S texlive-latexextra
sudo pacman -S texlive-plaingeneric

sudo pacman -S gimp

# for getting manga on kindle
yay -S kcc
yay -S kindlegen

sudo pacman -S tmux
