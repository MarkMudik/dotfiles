sudo pacman -S kitty --noconfirm

sudo pacman -S rofi  --noconfirm
sudo pacman -S waybar  --noconfirm
sudo pacman -S network-manager-applet --noconfirm


sudo pacman -S obsidian --noconfirm
sudo pacman -S yazi --noconfirm
sudo pacman -S emacs --noconfirm
sudo pacman -S neovim --noconfirm
sudo pacman -S calibre --noconfirm
sudo pacman -S ghostty --noconfirm
sudo pacman -S nautilus --noconfirm
sudo pacman -S 7zip --noconfirm
sudo pacman -S wl-clipboard --noconfirm
sudo pacman -S cliphist --noconfirm
sudo pacman -S hyprpaper --noconfirm
sudo pacman -S qt6-wayland --noconfirm
sudo pacman -S grim --noconfirm
sudo pacman -S slurp --noconfirm
sudo pacman -S pipewire --noconfirm
sudo pacman -S wireplumber --noconfirm
sudo pacman -S libnotify --noconfirm
sudo pacman -S pavucontrol --noconfirm
sudo pacman -S pulseaudio --noconfirm

sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay -S librewolf-bin

git clone --depth 1 --recursive https://github.com/kholia/OSX-KVM.git

sudo pacman -S ttf-meslo-nerd

sudo pacman -S bat --noconfirm
sudo pacman -S eza --noconfirm
sudo pacman -S zoxide --noconfirm
sudo pacman -S fzf --noconfirm
sudo pacman -S lazygit --noconfirm
sudo pacman -S ripgrep --noconfirm

yay -S vscode-langservers-extracted

sudo pacman -S steam --noconfirm
yay -S minecraft-launcher

sudo pacman -S zsh --noconfirm
sudo pacman -S zsh-syntax-highlighting --noconfirm
