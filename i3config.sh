#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Update system and install all packages
echo "Installing i3 and packages..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
    i3 i3blocks rofi feh arc-theme papirus-icon-theme \
    git lxappearance brightnessctl \
    network-manager x11-xserver-utils \
    numlockx unclutter \
    compton nitrogen \
    arandr flameshot \
    build-essential curl wget unzip \
    python3-pip

# Create config directories and copy files
echo "Setting up configuration..."
mkdir -p ~/.config/{i3,rofi,alacritty} ~/.local/share/fonts

# Copy all config files at once
[ -d "$SCRIPT_DIR/.config" ] && cp -a "$SCRIPT_DIR/.config/." ~/.config/
[ -f "$SCRIPT_DIR/.fehbg" ] && cp "$SCRIPT_DIR/.fehbg" ~/
[ -d "$SCRIPT_DIR/wallpaper" ] && cp -a "$SCRIPT_DIR/wallpaper" ~/.wallpaper

# Install i3-gaps if you want gaps functionality
echo "Installing i3-gaps..."
sudo apt install -y meson ninja-build libxcb-shape0-dev libxcb-keysyms1-dev \
    libpango1.0-dev libxcb-util0-dev libxcb1-dev libxcb-icccm4-dev libyajl-dev \
    libev-dev libxkbcommon-dev libxcb-xinerama0-dev libstartup-notification0-dev \
    libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev autoconf gcc make pkg-config \
    libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev \
    libx11-xcb-dev libxcb-xkb-dev libxcb-image0-dev libxkbcommon-x11-dev \
    libjpeg-dev libgif-dev blueman

if [ ! -d "i3-gaps" ]; then
    git clone https://github.com/Airblader/i3 i3-gaps
    cd i3-gaps && mkdir -p build && cd build
    meson .. && ninja && sudo ninja install
    cd ../..
fi

# Install i3lock-color
echo "Installing i3lock-color..."
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./install-i3lock-color.sh
cd ..
rm -rf i3lock-color

# Install i3-volume for audio control
echo "Installing i3-volume..."
git clone --depth 1 https://github.com/hastinbe/i3-volume.git ~/.config/i3/i3-volume 2>/dev/null || true
chmod +x ~/.config/i3/i3-volume/volume 2>/dev/null || true

# Install better Alacritty from source (if you prefer latest version)
echo "Building Alacritty from source..."
if ! command -v alacritty >/dev/null; then
    sudo apt install -y cargo cmake g++ pkg-config libfontconfig1-dev libxcb-xfixes0-dev
    git clone https://github.com/alacritty/alacritty.git /tmp/alacritty
    cd /tmp/alacritty
    cargo build --release
    sudo cp target/release/alacritty /usr/local/bin/
    cd /tmp && rm -rf alacritty
fi

# Install xkblayout-state for keyboard layout detection
echo "Installing xkblayout-state..."
if [ ! -f "/usr/local/bin/xkblayout-state" ]; then
    cd /tmp
    git clone https://github.com/nonpop/xkblayout-state.git
    cd xkblayout-state
    make
    sudo cp xkblayout-state /usr/local/bin/
    cd /tmp && rm -rf xkblayout-state
fi

# Install Nerd Fonts
echo "Installing Nerd Fonts..."
cd /tmp
fonts=("FiraCode" "JetBrainsMono" "Hack" "Iosevka" "RobotoMono" "SourceCodePro")

for font in "${fonts[@]}"; do
    echo "Installing ${font}..."
    wget -q "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/${font}.tar.xz"
    tar -xf "${font}.tar.xz" -C ~/.local/share/fonts/
    rm "${font}.tar.xz"
done

fc-cache -f

# Configure brightnessctl with suid permissions
echo "Setting up brightnessctl with suid..."
sudo chmod u+s /usr/bin/brightnessctl

# Install greenclip clipboard manager
echo "Installing greenclip..."
mkdir -p ~/.config/greenclip
if [ ! -f /usr/local/bin/greenclip ]; then
    wget -O /tmp/greenclip https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
    sudo cp /tmp/greenclip /usr/local/bin/
    sudo chmod +x /usr/local/bin/greenclip
    rm /tmp/greenclip
fi

# Make executable scripts executable
chmod +x ~/.config/i3/clipboard_fix.sh ~/.config/i3/battery-plus 2>/dev/null || true

# Configure i3-volume bindings if available
if [ -f ~/.config/i3/i3-volume/i3volume-pulseaudio.conf ] && [ -f ~/.config/i3/config ]; then
    if ! grep -q "i3volume\|XF86Audio" ~/.config/i3/config; then
        cat ~/.config/i3/i3-volume/i3volume-pulseaudio.conf >> ~/.config/i3/config
    fi
fi

echo "Setup complete! Reboot and select i3 at login."
echo "After login: Run lxappearance and select arc-dark theme"