#!/bin/bash
set -euo pipefail

# Check for sudo
if ! command -v sudo &>/dev/null; then
  echo "Error: 'sudo' is required but not installed."
  exit 1
fi

# Check for yay
echo "Checking for yay..."
if ! command -v yay &>/dev/null; then
  echo "'yay' is not installed."
  read -rp "Would you like to install yay now? [y/N]: " install_yay
  if [[ "$install_yay" =~ ^[Yy]$ ]]; then
    git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
    cd .. && rm -rf yay
  else
    echo "Cannot continue without yay. Exiting."
    exit 1
  fi
fi

sudo pacman -Syu --needed --noconfirm bash-completion
sudo pacman -S --needed --noconfirm git
sudo pacman -S --needed --noconfirm base-devel
sudo pacman -S --needed --noconfirm obsidian
sudo pacman -S --needed --noconfirm emacs
sudo pacman -S --needed --noconfirm ttf-meslo-nerd
sudo pacman -S --needed --noconfirm bat
sudo pacman -S --needed --noconfirm zoxide
sudo pacman -S --needed --noconfirm fd
sudo pacman -S --needed --noconfirm ripgrep
sudo pacman -S --needed --noconfirm steam
sudo pacman -S --needed --noconfirm qbittorrent
sudo pacman -S --needed --noconfirm wine
sudo pacman -S --needed --noconfirm winetricks
sudo pacman -S --needed --noconfirm libreoffice-fresh
sudo pacman -S --needed --noconfirm vulkan-tools
sudo pacman -S --needed --noconfirm vulkan-icd-loader
sudo pacman -S --needed --noconfirm openssh
sudo pacman -S --needed --noconfirm calibre
sudo pacman -S --needed --noconfirm neovim

#sudo pacman -S --needed --noconfirm hyprland
#sudo pacman -S --needed --noconfirm ghostty
#sudo pacman -S --needed --noconfirm wl-clipboard
#sudo pacman -S --needed --noconfirm cliphist
#sudo pacman -S --needed --noconfirm hyprpaper
#sudo pacman -S --needed --noconfirm qt6-wayland
#sudo pacman -S --needed --noconfirm grim
#sudo pacman -S --needed --noconfirm slurp
#sudo pacman -S --needed --noconfirm pipewire
#sudo pacman -S --needed --noconfirm wireplumber
#sudo pacman -S --needed --noconfirm libnotify
#sudo pacman -S --needed --noconfirm pavucontrol
#sudo pacman -S --needed --noconfirm rofi
#sudo pacman -S --needed --noconfirm waybar
#sudo pacman -S --needed --noconfirm nautilus
#sudo pacman -S --needed --noconfirm loupe
#sudo pacman -S --needed --noconfirm 7zip
#sudo pacman -S --needed --noconfirm xdg-desktop-portal

sudo pacman -S --needed --noconfirm xorg-server
sudo pacman -S --needed --noconfirm xorg-apps
sudo pacman -S --needed --noconfirm xorg-xinit
sudo pacman -S --needed --noconfirm xorg-twm
sudo pacman -S --needed --noconfirm xorg-xclock
sudo pacman -S --needed --noconfirm kitty

#sudo pacman -S --needed --noconfirm gnome
#sudo pacman -S --needed --noconfirm gnome-tweaks
#sudo pacman -S --needed --noconfirm gnome-shell-extensions
#sudo pacman -S --needed --noconfirm gnome-browser-connector
#sudo pacman -S --needed --noconfirm gdm
#sudo pacman -S --needed --noconfirm cups

sudo pacman -S --needed --noconfirm plasma
sudo pacman -S --needed --noconfirm sddm

yay -S --needed --noconfirm vscode-langservers-extracted 
yay -S --needed --noconfirm stremio
yay -S --needed --noconfirm librewolf-bin

sudo pacman -S --needed --noconfirm nmap
