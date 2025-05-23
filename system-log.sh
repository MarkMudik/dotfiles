sudo pacman -S hyprland
sudo pacman -S kitty

sudo pacman -S rofi 
sudo pacman -S waybar 
sudo pacman -S network-manager-applet


sudo pacman -S obsidian
sudo pacman -S yazi
sudo pacman -S emacs
sudo pacman -S neovim
sudo pacman -S calibre
sudo pacman -S ghostty
sudo pacman -S nautilus
sudo pacman -S 7zip
sudo pacman -S wl-clipboard
sudo pacman -S cliphist
sudo pacman -S hyprpaper
sudo pacman -S qt6-wayland
sudo pacman -S grim \
sudo pacman -S slurp
sudo pacman -S pipewire
sudo pacman -S wireplumber
sudo pacman -S libnotify
sudo pacman -S pavucontrol
sudo pacman -S pulseaudio

sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay -S librewolf-bin

# getting macos
sudo pacman -S --needed qemu libvirt virt-manager wget libguestfs p7zip make \
    tesseract tesseract-data-eng cdrtools net-tools screen edk2-ovmf
yay -S dmg2img

git clone --depth 1 --recursive https://github.com/kholia/OSX-KVM.git


sudo pacman -Rns qemu-full libvirt virt-manager libguestfs \
    tesseract tesseract-data-eng cdrtools net-tools screen edk2-ovmf
yay -Rns dmg2img

sudo pacman -S ttf-firacode-nerd
sudo pacman -S ttf-meslo-nerd
