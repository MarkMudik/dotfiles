#!/bin/bash
set -euo pipefail

WITH_HYPRLAND=false
WITH_XORG=false
WITH_GNOME=false
WITH_PLASMA=false

# Parse flags (supports any order)
for arg in "$@"; do
  case $arg in
    --with-hyprland) WITH_HYPRLAND=true ;;
    --with-xorg) WITH_XORG=true ;;
    --with-gnome) WITH_GNOME=true ;;
    --with-plasma) WITH_PLASMA=true ;;
    *) ;;
  esac
done

echo "Checking for yay..."
if ! command -v yay &> /dev/null; then
  echo "Error: 'yay' is not installed. Please install yay first."
  exit 1
fi

echo "Starting installation of categorized packages..."

# -------------------------------------------------------
# Essential Packages
# -------------------------------------------------------
essential_packages=(
  ghostty
  firefox
  git
  base-devel
  openvpn
  network-manager-applet
  obsidian
  emacs
  ttf-meslo-nerd
  bat
  eza
  zoxide
  fd
  fzf
  ripgrep
  steam
  qbittorrent
  wine
  winetricks
  libreoffice-fresh
  vulkan-tools
  vulkan-icd-loader
  less
  yazi
  zsh
  openssh
)

echo "Installing essential system packages..."
for pkg in "${essential_packages[@]}"; do
  echo "-> $pkg"
  sudo pacman -S --noconfirm --needed "$pkg"
done

# -------------------------------------------------------
# Hyprland / Wayland Packages (optional)
# -------------------------------------------------------
hyprland_packages=(
  wl-clipboard
  cliphist
  hyprpaper
  qt6-wayland
  grim
  slurp
  pipewire
  wireplumber
  libnotify
  pavucontrol
  pulseaudio
  rofi
  waybar
  nautilus
  loupe
  7zip
  xdg-desktop-portal
)

if [ "$WITH_HYPRLAND" = true ]; then
  echo "Installing Hyprland / Wayland packages..."
  for pkg in "${hyprland_packages[@]}"; do
    echo "-> $pkg"
    sudo pacman -S --noconfirm --needed "$pkg"
  done
else
  echo "Skipping Hyprland packages (use --with-hyprland to include them)"
fi

# -------------------------------------------------------
# Xorg Packages (optional)
# -------------------------------------------------------
xorg_packages=(
  xorg-server
  xorg-apps
  xorg-xinit
  xorg-twm
  xorg-xclock
)

if [ "$WITH_XORG" = true ]; then
  echo "Installing Xorg packages..."
  for pkg in "${xorg_packages[@]}"; do
    echo "-> $pkg"
    sudo pacman -S --noconfirm --needed "$pkg"
  done
else
  echo "Skipping Xorg packages (use --with-xorg to include them)"
fi

# -------------------------------------------------------
# GNOME Packages (optional)
# -------------------------------------------------------
gnome_packages=(
  gnome
  gnome-tweaks
  gnome-shell-extensions
  gdm
)

if [ "$WITH_GNOME" = true ]; then
  echo "Installing GNOME packages..."
  for pkg in "${gnome_packages[@]}"; do
    echo "-> $pkg"
    sudo pacman -S --noconfirm --needed "$pkg"
  done
  echo "Enabling GDM (GNOME Display Manager)..."
  sudo systemctl enable gdm
else
  echo "Skipping GNOME packages (use --with-gnome to include them)"
fi

# -------------------------------------------------------
# Plasma / KDE Packages (optional)
# -------------------------------------------------------
plasma_packages=(
  plasma
  plasma-wayland-session
  kde-applications
  sddm
)

if [ "$WITH_PLASMA" = true ]; then
  echo "Installing Plasma packages..."
  for pkg in "${plasma_packages[@]}"; do
    echo "-> $pkg"
    sudo pacman -S --noconfirm --needed "$pkg"
  done
  echo "Enabling SDDM (KDE Display Manager)..."
  sudo systemctl enable sddm
else
  echo "Skipping Plasma packages (use --with-plasma to include them)"
fi

# -------------------------------------------------------
# Optional GUI Tools (Prompt Per Package)
# -------------------------------------------------------
optional_packages=(
  dolphin
  calibre
  neovim
  prismlauncher
)

echo "Prompting for optional GUI tools..."
for pkg in "${optional_packages[@]}"; do
  read -rp "Do you want to install optional package '$pkg'? [y/N]: " choice
  case "$choice" in
    [yY][eE][sS]|[yY])
      echo "Installing $pkg..."
      sudo pacman -S --noconfirm --needed "$pkg"
      ;;
    *)
      echo "Skipping $pkg."
      ;;
  esac
done

# -------------------------------------------------------
# AUR Packages
# -------------------------------------------------------
aur_packages=(
  vscode-langservers-extracted
  stremio
  # citron
)

echo "Installing AUR packages..."
for pkg in "${aur_packages[@]}"; do
  echo "-> $pkg"
  yay -S --noconfirm "$pkg"
done

echo "✅ All packages installed successfully."
