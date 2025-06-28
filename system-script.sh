#!/bin/bash
set -euo pipefail

WITH_HYPRLAND=false
WITH_XORG=false
WITH_GNOME=false
WITH_PLASMA=false
WITH_HACKING=false
WITH_QEMU=false

# Parse flags
for arg in "$@"; do
  case $arg in
    --with-hyprland) WITH_HYPRLAND=true ;;
    --with-xorg) WITH_XORG=true ;;
    --with-gnome) WITH_GNOME=true ;;
    --with-plasma) WITH_PLASMA=true ;;
    --with-hacking) WITH_HACKING=true ;;
    --with-qemu) WITH_QEMU=true ;;
    *) ;;
  esac
done

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

echo "Starting installation of categorized packages..."

# -------------------------------------------------------
# Essential Packages
# -------------------------------------------------------
essential_packages=(
  bash-completion firefox git base-devel openvpn network-manager-applet
  obsidian emacs ttf-meslo-nerd bat eza zoxide fd fzf ripgrep steam
  qbittorrent wine winetricks libreoffice-fresh vulkan-tools
  vulkan-icd-loader less openssh

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
  hyprland ghostty wl-clipboard cliphist hyprpaper qt6-wayland
  grim slurp pipewire wireplumber libnotify pavucontrol rofi
  waybar nautilus loupe 7zip xdg-desktop-portal
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
  xorg-server xorg-apps xorg-xinit xorg-twm xorg-xclock
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
  gnome gnome-tweaks gnome-shell-extensions gnome-browser-connector gdm cups
)

if [ "$WITH_GNOME" = true ]; then
  echo "Installing GNOME packages..."
  for pkg in "${gnome_packages[@]}"; do
    echo "-> $pkg"
    sudo pacman -S --noconfirm --needed "$pkg"
  done
  echo "Enabling GDM (GNOME Display Manager)..."
  sudo systemctl enable gdm
  echo "You may need to reboot for the display manager to take effect."
else
  echo "Skipping GNOME packages (use --with-gnome to include them)"
fi

# -------------------------------------------------------
# Plasma / KDE Packages (optional)
# -------------------------------------------------------
plasma_packages=(
  plasma plasma-wayland-session kde-applications sddm ghostty
)

if [ "$WITH_PLASMA" = true ]; then
  echo "Installing Plasma packages..."
  for pkg in "${plasma_packages[@]}"; do
    echo "-> $pkg"
    sudo pacman -S --noconfirm --needed "$pkg"
  done
  echo "Enabling SDDM (KDE Display Manager)..."
  sudo systemctl enable sddm
  echo "You may need to reboot for the display manager to take effect."
else
  echo "Skipping Plasma packages (use --with-plasma to include them)"
fi

# -------------------------------------------------------
# Optional GUI Tools (Prompt Per Package)
# -------------------------------------------------------
optional_packages=(
  dolphin calibre neovim prismlauncher
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
  xcursor-breeze vscode-langservers-extracted stremio
  # citron
)

echo "Installing AUR packages..."
for pkg in "${aur_packages[@]}"; do
  echo "-> $pkg"
  yay -S --noconfirm --needed "$pkg"
done

# -------------------------------------------------------
# Cyber Security / Hacking Packages (optional)
# -------------------------------------------------------
hacking_packages=(
  nmap
  wireshark-cli
)

if [ "$WITH_HACKING" = true ]; then
  echo "Installing hacking packages..."
  for pkg in "${hacking_packages[@]}"; do
    echo "-> $pkg"
    sudo pacman -S --noconfirm --needed "$pkg"
  done
else
  echo "Skipping hacking packages (use --with-hacking to include them)"
fi

# -------------------------------------------------------
# QEMU / Virtualization Packages (optional)
# -------------------------------------------------------
qemu_packages=(
  qemu libvirt virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat
)

if [ "$WITH_QEMU" = true ]; then
  echo "Installing QEMU / KVM virtualization packages..."
  for pkg in "${qemu_packages[@]}"; do
    echo "-> $pkg"
    sudo pacman -S --noconfirm --needed "$pkg"
  done

  echo "Enabling and starting libvirtd service..."
  sudo systemctl enable --now libvirtd

  echo "Adding user to libvirt group..."
  sudo usermod -aG libvirt "$(whoami)"
  echo "-> Run 'newgrp libvirt' or reboot to apply group membership."
else
  echo "Skipping QEMU/KVM packages (use --with-qemu to include them)"
fi

echo "✅ All packages installed successfully."
