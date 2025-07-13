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
sudo pacman -Syu --needed --noconfirm tree
sudo pacman -Syu --needed --noconfirm stow
sudo pacman -S --needed --noconfirm git
sudo pacman -S --needed --noconfirm base-devel
sudo pacman -S --needed --noconfirm obsidian
sudo pacman -S --needed --noconfirm emacs
sudo pacman -S --needed --noconfirm ttf-meslo-nerd
sudo pacman -S --needed --noconfirm bat
sudo pacman -S --needed --noconfirm zoxide
sudo pacman -S --needed --noconfirm fd
sudo pacman -S --needed --noconfirm ripgrep
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
sudo pacman -S --needed --noconfirm firefox

sudo pacman -S --needed --noconfirm xorg-server
sudo pacman -S --needed --noconfirm xorg-apps
sudo pacman -S --needed --noconfirm xorg-xinit
sudo pacman -S --needed --noconfirm xorg-twm
sudo pacman -S --needed --noconfirm xorg-xclock

sudo pacman -S --needed --noconfirm gnome
sudo pacman -S --needed --noconfirm gnome-tweaks
sudo pacman -S --needed --noconfirm gnome-shell-extensions
sudo pacman -S --needed --noconfirm gnome-browser-connector
sudo pacman -S --needed --noconfirm gdm
sudo pacman -S --needed --noconfirm cups
sudo pacman -S --needed --noconfirm wl-clipboard

yay -S --needed --noconfirm vscode-langservers-extracted 
yay -S --needed --noconfirm stremio
yay -S --needed --noconfirm phinger-cursors
yay -S --needed --noconfirm jdownloader2

sudo pacman -S --needed --noconfirm nmap

yay -S --needed --noconfirm google-gemini-cli


# For virtual machines (vm's)
sudo pacman -S qemu-full
sudo pacman -S libvirt
sudo pacman -S virt-manager
sudo pacman -S dnsmasq
