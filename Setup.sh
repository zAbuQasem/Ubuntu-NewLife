#!/bin/bash -xe

# Variables
basedir=$(pwd)
workingdir="/tmp/Ubuntu-Setup"
######################

# Ensuring Sudo will not prompt for a password for some time
sudo ls /root &>/dev/null

mkdir $workingdir
cd $workingdir

# Basic updates
sudo apt update -y && sudo apt upgrade -y
sudo apt install software-properties-common

# Adding repositories
echo yes | sudo add-apt-repository ppa:atareao/atareao # xkb-switch 
echo yes | sudo add-apt-repository ppa:ondrej/php


sudo apt update -y 

# Installing alot of things
sudo apt install -y nautilus python3-launchpadlib build-essential snapd software-properties-common linux-headers-generic jq dirmngr numlockx brightnessctl xkb-switch exiftool gnupg apt-transport-https gdebi-core ca-certificates vim git curl wget  python3-dev python3-pip python3-distutils python3-venv p7zip-full zip unzip net-tools gdebi  openssh-server vsftpd samba sqlite3 default-jre gdb strace ltrace imagemagick  qtqr obs-studio flameshot zsh wireshark plocate xsel wl-clipboard ripgrep npm php fd-find bat smbclient nginx ipython3

# Install Docker
curl https://get.docker.com/  | sudo bash

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash

# Installing node
sudo npm install -g n
sudo n stable

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Adding current user to docker group
sudo usermod -a -G docker $USER

# Mandatory for i3 headache
#sudo chmod +s /usr/bin/brightnessctl

# Toggle apps by clickig (tested o ubuntu)
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize' &>/dev/null

# Installing ngrok , audacity , atom
echo -e "\n[*]Installing ngrok , audacity , atom " 
sudo service snapd restart
sudo systemctl enable snapd
sudo snap install ngrok
#sudo snap install audacity
#sudo snap install atom --classic

# Install golang
wget https://go.dev/dl/go1.22.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

# Installing Kubecolor
go install github.com/hidetatz/kubecolor/cmd/kubecolor@latest

# Installing vmware latest version
function VMWARE() {
	echo -e "\n[*]Installing VmWare"
	wget --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0" https://www.vmware.com/go/getplayer-linux
	chmod +x getplayer-linux
	sudo ./getplayer-linux --required --eulas-agreed
	echo "[!] If you faced issues due to kernel update: https://communities.vmware.com/t5/VMware-Workstation-Pro/VMware-16-2-3-not-working-on-Ubuntu-22-04-LTS/td-p/2905535"
} #&& VMWARE

function SUBLIMETEXT4() {
	echo -e "\n[*] Installing SublimeText-4"
	curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	echo yes | sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
	sudo apt update -y
	sudo apt install -y sublime-text 
} && SUBLIMETEXT4  


function TMUX() {
	echo -e "\n[*] Installing Tmux" 
	sudo apt install -y tmux
	curl https://raw.githubusercontent.com/zAbuQasem/Misc/main/tmux.conf -o ~/.tmux.conf
	# "tpm" plugin manager
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
} && TMUX 

function VSCODE() {
	echo -e "\n[*] Installing VScode"
	sudo apt install -y software-properties-common apt-transport-https wget
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
	echo yes | sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
	sudo apt install -y code
} && VSCODE 

function NVIM() {
	echo -e "\n[*] Installing NeoVim"
	# Installing Neovim
	wget https://github.com/neovim/neovim/releases/download/v0.9.1/nvim.appimage
	chmod u+x nvim.appimage && sudo mv nvim.appimage /usr/bin/nvim
	# Installing config file
	git clone https://github.com/LunarVim/nvim-basic-ide.git ~/.config/nvim
	# "Plug" package manager
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	} && NVIM 

function FORENSICS() {
	echo -e "\n[*] Installing Forensics-all package"
	sudo apt install -y forensics-all
} #&& FORENSICS

function OBSIDIAN() {
	echo -e "\n[*] Installing Obsidian-notes" 
	wget "https://github.com/obsidianmd/obsidian-releases/releases/download/v0.14.6/obsidian_0.14.6_amd64.deb"
	chmod +x 'obsidian_0.14.6_amd64.deb'
	sudo dpkg -i ./'obsidian_0.14.6_amd64.deb'

} #&& OBSIDIAN 

function NOTES() {
	echo -e "\n[*] Installing MyNotes"
	cd ~/Documents
	git clone https://github.com/zAbuQasem/MyNotes
	# Returning to the working directory
	cd $workingdir
} #&& NOTES

function K8S(){
	echo -e "\n[*] Installing Minikube"
	wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	chmod +x minikube-linux-amd64
	sudo mv minikube-linux-amd64 /usr/local/bin/minikube
	curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
	chmod +x ./kubectl
	sudo mv ./kubectl /usr/local/bin/kubectl
} && K8S

function DISCORD() {
	echo -e "\n[*] Installing Discord"
	wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
	sudo dpkg -i $workingdir/discord.deb
} && DISCORD 

function AWSCLI() {
	echo -e "\n[*] Installing AWS-CLI"
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
} && AWSCLI 

function GHIDRA() {
	echo -e "\n[*] Installing Ghidra_10.2.3"
	wget "https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.2.3_build/ghidra_10.2.3_PUBLIC_20230208.zip"
	sudo unzip ghidra_10.2.3_PUBLIC_20230208.zip -d /usr/share/ghidra
	wget "https://raw.githubusercontent.com/Crypto-Cat/CTF/main/auto_ghidra.py"
	chmod +x auto_ghidra.py
	sed -i '1s/^/#!\/usr\/bin\/env python3 \n/' auto_ghidra.py
	sudo mv auto_ghidra.py /usr/bin/auto_ghidra
} #&& GHIDRA 

function debuggers() {
	cd ~ && git clone https://github.com/apogiatzis/gdb-peda-pwndbg-gef.git
	cd ~/gdb-peda-pwndbg-gef
	./install.sh
	cd $workingdir
} #&& debuggers

function PYCHARM() {
	# Last function to call as it requires GUI interaction
	echo -e "\n[*] Installing Pycharm"
	sudo snap install pycharm-community --classic
} #&& PYCHARM


function PYTHONLIBS(){
	echo -e "\n[*] Installing Python3 packages"
	pip3 install --no-warn-script-location updog trufflehog rich flask-unsign flask paramiko pyngrok pwntools z3-solver pwncat-cs pynvim git-dumper arsenal-cli
} && PYTHONLIBS

function MSTEAMS() {
	echo -e "\n[*] Installing Microsoft teams"
	# Ensuring sudo pass again...
	sudo ls
	curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'
	sudo apt update -y && sudo apt install -y teams
} && MSTEAMS

function GITHUBDESKTOP(){
	echo -e "\n[*] Installing Github desktop"
	wget https://github.com/shiftkey/desktop/releases/download/release-3.3.6-linux3/GitHubDesktop-linux-amd64-3.3.6-linux3.deb 
	echo y | sudo gdebi GitHubDesktop-linux-amd64-3.3.6-linux3.deb
} && GITHUBDESKTOP

function I3(){
	echo -e "\n[*] Installing i3 desktop"
	cd $basedir
	chmod +x "./i3config.sh"
	./i3config.sh
} #&& I3 


RUN() {
	# Cleanups
	sudo apt-get clean
	sudo apt -y autoremove
	echo "[+] Finished the setup process, Please view ./errors.log in case of corruption"
	echo  -e "\033[5m---> Please restart your computer!\033[0m"
} && RUN
