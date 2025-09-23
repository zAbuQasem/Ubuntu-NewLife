#!/bin/bash

set -eou pipefail

# Global variables
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly LOG_FILE="/tmp/i3config_install.log"

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Function to check if command succeeded
check_status() {
    if [ $? -eq 0 ]; then
        log "✓ $1 completed successfully"
    else
        log "✗ $1 failed"
        exit 1
    fi
}

# Function to update system packages
update_system() {
    log "Starting system update..."
    sudo apt update && sudo apt upgrade -y
    check_status "System update"
}

# Function to install i3 and related packages
install_i3_packages() {
    log "Installing i3 and related packages..."
    sudo apt-get install -y \
        arandr flameshot arc-theme feh i3blocks i3status i3 i3-wm git \
        lxappearance python3-pip rofi unclutter cargo compton \
        papirus-icon-theme imagemagick brightnessctl x11-xserver-utils numlockx
    check_status "i3 packages installation"
}

# Function to install development dependencies
install_dev_dependencies() {
    log "Installing development dependencies..."
    sudo apt-get install -y \
        libxcb-shape0-dev libxcb-keysyms1-dev libpango1.0-dev \
        libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev \
        libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev \
        libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev \
        libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 \
        libxcb-xrm-dev autoconf meson
    check_status "Development dependencies installation"
    
    sudo apt-get install -y \
        libxcb-render-util0-dev libxcb-shape0-dev libxcb-xfixes0-dev
    check_status "Additional development dependencies installation"
}

# Function to install Alacritty dependencies
install_alacritty_dependencies() {
    log "Installing Alacritty dependencies..."
    sudo apt install -y \
        cmake g++ pkg-config libfontconfig1-dev \
        libxcb-xfixes0-dev libxkbcommon-dev python3
    check_status "Alacritty dependencies installation"
}

# Function to build and install Alacritty from source
install_alacritty_from_source() {
    log "Building Alacritty from source..."
    if [ -d "alacritty" ]; then
        log "Removing existing alacritty directory..."
        rm -rf alacritty
    fi
    
    git clone https://github.com/alacritty/alacritty.git
    check_status "Alacritty repository clone"
    
    cd alacritty
    cargo build --release
    check_status "Alacritty build"
    
    sudo cp target/release/alacritty /usr/local/bin
    sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
    sudo desktop-file-install extra/linux/Alacritty.desktop
    sudo update-desktop-database
    check_status "Alacritty installation"
    
    cd ..
}

# Function to install Alacritty from .deb package (fallback)
install_alacritty_deb() {
    log "Installing Alacritty from .deb package..."
    local deb_file="alacritty_0.10.1-1_amd64_bullseye.deb"
    
    if [ ! -f "$deb_file" ]; then
        wget https://github.com/barnumbirr/alacritty-debian/releases/download/v0.10.1-1/"$deb_file"
        check_status "Alacritty .deb download"
    fi
    
    sudo dpkg -i "$deb_file"
    sudo apt install -f -y
    check_status "Alacritty .deb installation"
}

# Function to get latest Nerd Fonts version from GitHub API
get_latest_nerd_fonts_version() {
    local api_url="https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest"
    local version
    
    if command -v curl >/dev/null 2>&1; then
        version=$(curl -s "$api_url" | grep '"tag_name"' | cut -d'"' -f4 | tr -d '\n\r')
    elif command -v wget >/dev/null 2>&1; then
        version=$(wget -qO- "$api_url" | grep '"tag_name"' | cut -d'"' -f4 | tr -d '\n\r')
    else
        version="v3.4.0"
    fi
    
    if [ -z "$version" ] || [[ ! "$version" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        version="v3.4.0"
    fi
    
    echo "$version"
}

# Function to install fonts
install_fonts() {
    log "Installing Nerd Fonts..."
    mkdir -p ~/.local/share/fonts/
    
    local fonts_dir="$HOME/.local/share/fonts"
    
    log "Fetching latest Nerd Fonts version from GitHub..."
    local nerd_fonts_version
    nerd_fonts_version=$(get_latest_nerd_fonts_version)
    
    if [ -z "$nerd_fonts_version" ]; then
        log "✗ Error: Failed to get Nerd Fonts version"
        return 1
    fi
    
    log "Latest Nerd Fonts version: $nerd_fonts_version"
    
    # Define fonts to download with their archive names
    local fonts=(
        "Iosevka:Iosevka.tar.xz"
        "RobotoMono:RobotoMono.tar.xz"
        "JetBrainsMono:JetBrainsMono.tar.xz"
        "FiraCode:FiraCode.tar.xz"
        "Hack:Hack.tar.xz"
        "SourceCodePro:SourceCodePro.tar.xz"
    )
    
    # Base URL for Nerd Fonts releases
    local base_url="https://github.com/ryanoasis/nerd-fonts/releases/download/${nerd_fonts_version}"
    
    log "Downloading fonts from Nerd Fonts ${nerd_fonts_version}..."
    log "Base URL: ${base_url}"
    
    for font_info in "${fonts[@]}"; do
        local font_name="${font_info%:*}"
        local archive_name="${font_info#*:}"
        local download_url="${base_url}/${archive_name}"
        
        log "Processing ${font_name}..."

        # Download font if not already present
        if [ ! -f "$archive_name" ]; then
            log "Downloading ${font_name} from ${download_url}..."
            if command -v curl >/dev/null 2>&1; then
                curl -LOf "$download_url"
            elif command -v wget >/dev/null 2>&1; then
                wget "$download_url"
            else
                log "✗ Error: Neither curl nor wget found. Cannot download fonts."
                return 1
            fi
            
            if [ $? -eq 0 ]; then
                log "✓ ${font_name} downloaded successfully"
            else
                log "⚠ Warning: Failed to download ${font_name}, skipping..."
                continue
            fi
        else
            log "✓ ${font_name} archive already exists, skipping download"
        fi

        # Extract font archive
        if [ -f "$archive_name" ]; then
            log "Extracting ${font_name}..."
            
            # Create temporary directory for extraction
            local temp_dir="${font_name}_temp"
            mkdir -p "$temp_dir"
            
            # Extract based on file extension
            if [[ "$archive_name" == *.tar.xz ]]; then
                tar -xf "$archive_name" -C "$temp_dir"
            elif [[ "$archive_name" == *.zip ]]; then
                unzip -o "$archive_name" -d "$temp_dir"
            fi
            
            # Copy font files to fonts directory
            find "$temp_dir" -type f \( -name "*.ttf" -o -name "*.otf" \) -exec cp {} "$fonts_dir/" \;
            
            # Clean up temporary directory
            rm -rf "$temp_dir"
            
            log "✓ ${font_name} extracted and installed"
        fi
    done

    # Update font cache
    log "Updating font cache..."
    fc-cache -fv >/dev/null 2>&1
    check_status "Font installation and cache update"
    
    # Clean up downloaded archives
    log "Cleaning up downloaded font archives..."
    local cleaned_count=0
    for font_info in "${fonts[@]}"; do
        local archive_name="${font_info#*:}"
        if [ -f "$archive_name" ]; then
            rm -f "$archive_name"
            log "✓ Removed $archive_name"
            ((cleaned_count++))
        fi
    done
    
    if [ $cleaned_count -gt 0 ]; then
        log "✓ Cleaned up $cleaned_count font archives"
    else
        log "ℹ No font archives to clean up"
    fi
    
    # Display installed fonts count
    local font_count
    font_count=$(find "$fonts_dir" -type f \( -name "*.ttf" -o -name "*.otf" \) | wc -l)
    log "✓ Total fonts installed: ${font_count}"
}

# Function to clone and install i3-gaps
install_i3_gaps() {
    log "Installing i3-gaps..."
    if [ -d "i3-gaps" ]; then
        log "Removing existing i3-gaps directory..."
        rm -rf i3-gaps
    fi
    
    git clone https://www.github.com/Airblader/i3 i3-gaps
    check_status "i3-gaps repository clone"
    
    cd i3-gaps
    mkdir -p build
    cd build
    meson ..
    ninja
    sudo ninja install
    check_status "i3-gaps build and installation"
    
    cd ../..
}

# Function to clone i3-volume
clone_i3_volume() {
    log "Cloning i3-volume into ~/.config/i3/i3-volume..."
    local target_dir="$HOME/.config/i3/i3-volume"
    mkdir -p "$(dirname "$target_dir")"

    if [ -d "$target_dir" ]; then
        log "Removing existing $target_dir ..."
        rm -rf "$target_dir"
    fi

    git clone --depth 1 https://github.com/hastinbe/i3-volume.git "$target_dir"
    check_status "i3-volume repository clone"

    # Ensure the main script is executable
    if [ -f "$target_dir/volume" ]; then
        chmod +x "$target_dir/volume"
    fi

    # Create a compatibility wrapper so 'volume' works from PATH
    local bin_dir="$HOME/.local/bin"
    mkdir -p "$bin_dir"
    cat > "$bin_dir/volume" <<'EOF'
#!/usr/bin/env bash
exec "$HOME/.config/i3/i3-volume/volume" "$@"
EOF
    chmod +x "$bin_dir/volume"
    log "Created wrapper at $bin_dir/volume pointing to $target_dir/volume"

    # Remove legacy location if it exists to avoid confusion
    if [ -d "$HOME/i3-volume" ]; then
        rm -rf "$HOME/i3-volume"
        log "Removed legacy ~/i3-volume directory"
    fi
}

# Function to create configuration directories
create_config_directories() {
    log "Creating configuration directories..."
    mkdir -p ~/.config/i3
    mkdir -p ~/.config/compton
    mkdir -p ~/.config/rofi
    mkdir -p ~/.config/alacritty
    check_status "Configuration directories creation"
}

# Function to copy configuration files
copy_config_files() {
    log "Copying configuration files..."
    local config_files=(
        ".config/i3/config:~/.config/i3/config"
        ".config/alacritty/alacritty.toml:~/.config/alacritty/alacritty.toml"
        ".config/i3/i3blocks.conf:~/.config/i3/i3blocks.conf"
        ".config/compton/compton.conf:~/.config/compton/compton.conf"
        ".config/rofi/config.rasi:~/.config/rofi/config.rasi"
        ".config/rofi/theme.rasi:~/.config/rofi/theme.rasi"
        ".fehbg:~/.fehbg"
        ".config/i3/clipboard_fix.sh:~/.config/i3/clipboard_fix.sh"
        ".config/i3/battery-plus:~/.config/i3/battery-plus"
    )
    
    for config in "${config_files[@]}"; do
        local src="${config%:*}"
        local dest="${config#*:}"
        dest=$(eval echo "$dest")  # Expand tilde
        
        if [ -f "$SCRIPT_DIR/$src" ]; then
            cp "$SCRIPT_DIR/$src" "$dest"
            log "✓ Copied $src to $dest"
        else
            log "⚠ Warning: Source file $src not found"
        fi
    done
    
    # If a legacy YAML Alacritty config exists at destination, suggest migration once
    if [ -f "$HOME/.config/alacritty/alacritty.yml" ]; then
        log "ℹ Detected legacy Alacritty YAML config at ~/.config/alacritty/alacritty.yml. Consider migrating with 'alacritty migrate'."
    fi

    # Make battery-plus executable
    if [ -f ~/.config/i3/battery-plus ]; then
        chmod +x ~/.config/i3/battery-plus
        check_status "Making battery-plus executable"
    fi
}


# Function to install and configure greenclip
install_configure_greenclip() {
  log "Installing and configuring greenclip..."
  
  # Create local bin directory if it doesn't exist
  local bin_dir="$HOME/.local/bin"
  mkdir -p "$bin_dir"
  
  # Download greenclip if not already present
  local greenclip_path="$bin_dir/greenclip"
  if [ ! -f "$greenclip_path" ]; then
    log "Downloading greenclip v4.2..."
    wget -O "$greenclip_path" https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
    check_status "greenclip download"
    
    # Make it executable
    chmod +x "$greenclip_path"
    log "✓ Made greenclip executable"
  else
    log "✓ greenclip already exists at $greenclip_path"
  fi
  
  # Create systemd user service for greenclip daemon
  log "Creating greenclip systemd service..."
  local service_dir="$HOME/.config/systemd/user"
  mkdir -p "$service_dir"
  
  cat > "$service_dir/greenclip.service" <<EOF
[Unit]
Description=Greenclip clipboard manager
After=graphical-session.target

[Service]
Type=simple
ExecStart=$greenclip_path daemon
Restart=on-failure
RestartSec=3
Environment=DISPLAY=:0

[Install]
WantedBy=default.target
EOF
  
  # Reload systemd user daemon and enable the service
  systemctl daemon-reload
  systemctl enable greenclip.service
  systemctl start greenclip.service
  check_status "greenclip service creation and startup"
  
  # Configure greenclip
  log "Configuring greenclip..."
  mkdir -p ~/.config/greenclip
  local conf_src="$SCRIPT_DIR/.config/greenclip/config"
  local conf_dest="$HOME/.config/greenclip/config"
  
  if [ -f "$conf_src" ]; then
    cp "$conf_src" "$conf_dest"
    check_status "greenclip configuration copy"
  else
    log "⚠ Warning: greenclip configuration source not found"
  fi
  
  # Verify installation
  if command -v greenclip >/dev/null 2>&1 || [ -x "$greenclip_path" ]; then
    log "✓ greenclip installed and configured successfully"
  else
    log "⚠ Warning: greenclip installation may have failed"
  fi
}

# Function to configure i3-volume
configure_i3_volume() {
    log "Configuring i3-volume (appending pulseaudio bindings if not present)..."
    local conf_src="$HOME/.config/i3/i3-volume/i3volume-pulseaudio.conf"
    local conf_dest="$HOME/.config/i3/config"

    if [ -f "$conf_src" ] && [ -f "$conf_dest" ]; then
        # Append only if a known marker from the file is not already present
        if ! grep -q "i3volume" "$conf_dest" && ! grep -q "XF86Audio" "$conf_dest"; then
            cat "$conf_src" >> "$conf_dest"
            check_status "i3-volume configuration appended"
        else
            log "i3-volume bindings appear to already be present; skipping append"
        fi
    else
        log "⚠ Warning: i3-volume configuration source or destination not found"
    fi
}

# Function to copy wallpapers
copy_wallpapers() {
    log "Copying wallpapers..."
    if [ -d "$SCRIPT_DIR/wallpaper" ]; then
        cp -r "$SCRIPT_DIR/wallpaper" ~/.wallpaper
        check_status "Wallpaper copy"
    else
        log "⚠ Warning: Wallpaper directory not found"
    fi
}

# Function to display final message
show_completion_message() {
    log "Installation completed successfully!"
    echo ""
    echo "=========================================="
    echo "Installation Complete!"
    echo "=========================================="
    echo "After reboot:"
    echo "1. Select i3 on login"
    echo "2. Run lxappearance and select arc-dark theme"
    echo ""
    echo "Log file saved to: $LOG_FILE"
    echo "=========================================="
}

# Main function to orchestrate the installation
main() {
    log "Starting i3 configuration script..."
    
    update_system
    install_i3_packages
    install_dev_dependencies
    install_alacritty_dependencies
    
    # Try to build Alacritty from source, fallback to .deb if it fails
    if ! install_alacritty_from_source 2>/dev/null; then
        log "⚠ Alacritty source build failed, trying .deb package..."
        install_alacritty_deb
    fi
    
    install_fonts
    clone_i3_volume
    install_i3_gaps
    create_config_directories
    copy_config_files
    configure_i3_volume
    copy_wallpapers
    show_completion_message
}

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi

