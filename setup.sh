#!/bin/bash

# Colors for output
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
CYAN="\033[0;36m"
NC="\033[0m"  # No Color

# Variables
workingdir="/tmp/Ubuntu-Setup"
errorlog="${workingdir}/errors.log"
GO_VERSION="1.23.2"
NEOVIM_VERSION="0.10.0"

# Create working directory and log file
mkdir -p "${workingdir}"
cd "${workingdir}"
touch "${errorlog}"

# Function to log errors
trap 'echo -e "${RED}An error occurred. Check ${errorlog}${NC}"; exit 1' ERR

# Ensuring Sudo will not prompt for a password for some time
sudo ls /root &>/dev/null

# Basic dependencies
echo -e "${CYAN}\n[*] Installing Basic Dependencies...${NC}"
sudo apt update -y
sudo apt install -y software-properties-common curl wget unzip 2>&1 | tee -a "${errorlog}"

# Install Core Utilities
function install_core() {
  echo -e "${CYAN}\n[*] Installing Core Utilities...${NC}"
  sudo apt install -y nautilus python3-launchpadlib build-essential fzf zsh snapd linux-headers-generic jq \
    dirmngr numlockx exiftool gnupg apt-transport-https gdebi-core ca-certificates \
    vim python3-dev python3-pip python3-distutils python3-venv p7zip-full zip unzip net-tools \
    gdebi openssh-server vsftpd samba sqlite3 default-jre gdb strace ltrace obs-studio flameshot \
    zsh wireshark plocate xsel xclip wl-clipboard ripgrep npm fd-find bat smbclient nginx ipython3 most stacer 2>&1 | tee -a "${errorlog}"
}

# Install Missing Libraries and Utilities
function install_additional_libs() {
  echo -e "${CYAN}\n[*] Installing Additional Libraries and Utilities...${NC}"
  sudo apt install -y arandr flameshot arc-theme feh lxappearance python3-pip \
    rofi unclutter papirus-icon-theme imagemagick libxcb-shape0-dev libxcb-keysyms1-dev \
    libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev \
    libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev \
    libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev autoconf meson libxcb-render-util0-dev libxcb-xfixes0-dev 2>&1 | tee -a "${errorlog}"
}

# Install Fonts
function install_fonts() {
  echo -e "${CYAN}\n[*] Installing Fonts...${NC}"
  mkdir -p ~/.local/share/fonts/
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip -O Iosevka.zip 2>&1 | tee -a "${errorlog}"
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/RobotoMono.zip -O RobotoMono.zip 2>&1 | tee -a "${errorlog}"
  unzip Iosevka.zip -d ~/.local/share/fonts/ 2>&1 | tee -a "${errorlog}"
  unzip RobotoMono.zip -d ~/.local/share/fonts/ 2>&1 | tee -a "${errorlog}"
  fc-cache -fv 2>&1 | tee -a "${errorlog}"
}

# Install Docker if not present
function install_docker() {
  if ! command -v docker &>/dev/null; then
    echo -e "${CYAN}\n[*] Installing Docker...${NC}"
    curl -fsSL https://get.docker.com/ | sudo bash 2>&1 | tee -a "${errorlog}"
    sudo usermod -a -G docker "${USER}"
  fi
}

# Install Rust
function install_rust() {
  echo -e "${CYAN}\n[*] Installing Rust...${NC}"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y 2>&1 | tee -a "${errorlog}"
  cargo install lsd || true
}

# Install Node.js (stable)
function install_node() {
  echo -e "${CYAN}\n[*] Installing Node.js...${NC}"
  sudo npm install -g n 2>&1 | tee -a "${errorlog}"
  sudo n stable 2>&1 | tee -a "${errorlog}"
}

# Install and configure fzf
function install_fzf() {
  echo -e "${CYAN}\n[*] Installing fzf...${NC}"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf 2>&1 | tee -a "${errorlog}"
  ~/.fzf/install --all 2>&1 | tee -a "${errorlog}"
}

# Install additional applications
function install_apps() {
  echo -e "${CYAN}\n[*] Installing ngrok, audacity, atom...${NC}"
  sudo service snapd restart 2>&1 | tee -a "${errorlog}"
  sudo systemctl enable snapd 2>&1 | tee -a "${errorlog}"
  sudo snap install ngrok 2>&1 | tee -a "${errorlog}"
}

# Install Go
function install_go() {
  echo -e "${CYAN}\n[*] Installing Go...${NC}"
  wget "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" 2>&1 | tee -a "${errorlog}"
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf "go${GO_VERSION}.linux-amd64.tar.gz" 2>&1 | tee -a "${errorlog}"
  export PATH="${PATH}:/usr/local/go/bin"
}

# Install Sublime Text 4
function install_sublimetext4() {
  echo -e "${CYAN}\n[*] Installing SublimeText-4...${NC}"
  curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo gpg --dearmor -o /usr/share/keyrings/sublimehq-archive-keyring.gpg 2>&1 | tee -a "${errorlog}"
  echo "deb [signed-by=/usr/share/keyrings/sublimehq-archive-keyring.gpg] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list 2>&1 | tee -a "${errorlog}"
  sudo apt update -y 2>&1 | tee -a "${errorlog}"
  sudo apt install -y sublime-text 2>&1 | tee -a "${errorlog}"
}

# Install tmux and configuration
function install_tmux() {
  echo -e "${CYAN}\n[*] Installing Tmux...${NC}"
  sudo apt install -y tmux 2>&1 | tee -a "${errorlog}"
  curl -fsSL https://raw.githubusercontent.com/zAbuQasem/Misc/main/tmux.conf -o ~/.tmux.conf 2>&1 | tee -a "${errorlog}"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>&1 | tee -a "${errorlog}"
}

# Install VScode
function install_vscode() {
  echo -e "${CYAN}\n[*] Installing Visual Studio Code...${NC}"
  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo gpg --dearmor -o /usr/share/keyrings/packages.microsoft.gpg 2>&1 | tee -a "${errorlog}"
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list 2>&1 | tee -a "${errorlog}"
  sudo apt update -y 2>&1 | tee -a "${errorlog}"
  sudo apt install -y code 2>&1 | tee -a "${errorlog}"
}

# Install NeoVim
function install_nvim() {
  echo -e "${CYAN}\n[*] Installing NeoVim...${NC}"
  wget "https://github.com/neovim/neovim/releases/download/v${NEOVIM_VERSION}/nvim.appimage" 2>&1 | tee -a "${errorlog}"
  chmod u+x nvim.appimage
  sudo mv nvim.appimage /usr/bin/nvim 2>&1 | tee -a "${errorlog}"
  git clone https://github.com/NvChad/starter ~/.config/nvim 2>&1 | tee -a "${errorlog}"
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' 2>&1 | tee -a "${errorlog}"
}

# Install DevOps Tools
function install_devops_tools() {
  echo -e "${CYAN}\n[*] Installing DevOps Tools...${NC}"
  
  # Install ArgoCD
  curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64 2>&1 | tee -a "${errorlog}"
  sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd 2>&1 | tee -a "${errorlog}"
  rm argocd-linux-amd64

  # Install Helm
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash 2>&1 | tee -a "${errorlog}"

  # Install Kubecolor
  go install github.com/kubecolor/kubecolor@latest 2>&1 | tee -a "${errorlog}"

  # Configure Kubernetes apt repository
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x kubectl
  sudo mv kubectl /usr/local/bin
}

# Final Cleanup and Reboot Prompt
function final_cleanup() {
  echo -e "${CYAN}\n[*] Final Cleanup...${NC}"
  sudo apt-get update --fix-missing
  sudo apt upgrade -y
  sudo apt clean 2>&1 | tee -a "${errorlog}"
  sudo apt autoremove -y 2>&1 | tee -a "${errorlog}"
  rm -rf "${workingdir}"
  echo -e "${GREEN}[+] Finished the setup process. Please check ${errorlog} in case of any errors.${NC}"
  echo -e "${YELLOW}---> Please restart your computer!${NC}"
}

# Main function to call all installation functions
function main() {
  add_repos
  install_core
  install_additional_libs
  install_fonts
  install_docker
  install_rust
  install_node
  install_fzf
  install_apps
  install_go
  install_sublimetext4
  install_tmux
  install_vscode
  install_nvim
  install_devops_tools
  final_cleanup
}

# Run main function
main
