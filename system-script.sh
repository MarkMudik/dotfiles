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

sudo pacman -S --needed bash-completion
sudo pacman -S --needed firefox
sudo pacman -S --needed git
sudo pacman -S --needed base-devel
sudo pacman -S --needed openvpn
sudo pacman -S --needed network-manager-applet
sudo pacman -S --needed obsidian
sudo pacman -S --needed emacs
sudo pacman -S --needed ttf-meslo-nerd
sudo pacman -S --needed bat
sudo pacman -S --needed zoxide
sudo pacman -S --needed fd
sudo pacman -S --needed ripgrep
sudo pacman -S --needed steam
sudo pacman -S --needed qbittorrent
sudo pacman -S --needed wine
sudo pacman -S --needed winetricks
sudo pacman -S --needed libreoffice-fresh
sudo pacman -S --needed vulkan-tools
sudo pacman -S --needed vulkan-icd-loader
sudo pacman -S --needed less
sudo pacman -S --needed openssh
sudo pacman -S --needed calibre
sudo pacman -S --needed neovim

#sudo pacman -S --needed hyprland
#sudo pacman -S --needed ghostty
#sudo pacman -S --needed wl-clipboard
#sudo pacman -S --needed cliphist
#sudo pacman -S --needed hyprpaper
#sudo pacman -S --needed qt6-wayland
#sudo pacman -S --needed grim
#sudo pacman -S --needed slurp
#sudo pacman -S --needed pipewire
#sudo pacman -S --needed wireplumber
#sudo pacman -S --needed libnotify
#sudo pacman -S --needed pavucontrol
#sudo pacman -S --needed rofi
#sudo pacman -S --needed waybar
#sudo pacman -S --needed nautilus
#sudo pacman -S --needed loupe
#sudo pacman -S --needed 7zip
#sudo pacman -S --needed xdg-desktop-portal

sudo pacman -S --needed xorg-server
sudo pacman -S --needed xorg-apps
sudo pacman -S --needed xorg-xinit
sudo pacman -S --needed xorg-twm
sudo pacman -S --needed xorg-xclock
sudo pacman -S --needed kitty

#sudo pacman -S --needed gnome
#sudo pacman -S --needed gnome-tweaks
#sudo pacman -S --needed gnome-shell-extensions
#sudo pacman -S --needed gnome-browser-connector
#sudo pacman -S --needed gdm
#sudo pacman -S --needed cups

sudo pacman -S --needed plasma
sudo pacman -S --needed sddm

yay -S --needed vscode-langservers-extracted 
yay -S --needed stremio

sudo pacman -S --needed nmap
