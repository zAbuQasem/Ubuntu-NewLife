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

# Adding repositories
echo yes | sudo add-apt-repository ppa:gerardpuig/ppa # ubuntu-cleaner
echo yes | sudo add-apt-repository ppa:videolan/master-daily # VLC
echo yes | sudo add-apt-repository ppa:eugenesan/ppa # caffeine
echo yes | sudo add-apt-repository ppa:webupd8team/indicator-kedeconnect # KDE connect
echo yes | sudo add-apt-repository ppa:obsproject/obs-studio # OBS-Studio screen recorder
echo yes | sudo add-apt-repository ppa:atareao/atareao # xkb-switch 


sudo apt update -y 

# Installing alot of things
sudo apt install -y build-essential linux-headers-generic dirmngr numlockx brightnessctl xkb-switch exiftool gnupg apt-transport-https gdebi-core ca-certificates software-properties-common vim git curl wget  python3-dev python3-pip python3-distutils python3-venv p7zip-full zip unzip net-tools gdebi snapd openssh-server vsftpd samba sqlite3 default-jre gdb strace ltrace imagemagick gimp vlc qtwayland5 synaptic  telegram-desktop caffeine  atril kdeconnect  qtqr obs-studio flameshot chromium-browser zsh docker.io wireshark golang-go plocate 

# Adding current user to docker group
sudo usermod -a -G docker $USER

# Mandatory for i3 headache
sudo chmod +s /usr/bin/brightnessctl

# Toggle apps by clickig (tested o ubuntu)
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize' &>/dev/null

# Installing ngrok , audacity , atom
echo -e "\n[*]Installing ngrok , audacity , atom " | tee -a errors.log
sudo snap install ngrok
sudo snap install audacity
sudo snap install atom --classic


# Installing vmware latest version
function VMWARE() {
	echo -e "\n[*]Installing VmWare" | tee -a errors.log
	wget --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0" https://www.vmware.com/go/getplayer-linux
	chmod +x getplayer-linux
	sudo ./getplayer-linux --required --eulas-agreed
	echo "[!] If you faced issues due to kernel update: https://communities.vmware.com/t5/VMware-Workstation-Pro/VMware-16-2-3-not-working-on-Ubuntu-22-04-LTS/td-p/2905535"
} && VMWARE

function SUBLIMETEXT4() {
	echo -e "\n[*] Installing SublimeText-4" | tee -a errors.log
	curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	echo yes | sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
	sudo apt update -y
	sudo apt install -y sublime-text 
} && SUBLIMETEXT4  


function TMUX() {
	echo -e "\n[*] Installing Tmux" | tee -a errors.log
	sudo apt install -y tmux
	curl https://raw.githubusercontent.com/zAbuQasem/Misc/main/tmux.conf -o ~/.tmux.conf
	# "tpm" plugin manager
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
} && TMUX 

function VSCODE() {
	echo -e "\n[*] Installing VScode" | tee -a errors.log
	sudo apt install -y software-properties-common apt-transport-https wget
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
	echo yes | sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
	sudo apt install -y code
} && VSCODE 

function NVIM() {
	echo -e "\n[*] Installing NeoVim" | tee -a errors.log
	# Installing Neovim
	wget https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.deb
	sudo dpkg -i ./nvim-linux64.deb
	# Installing config file
	
	git clone https://github.com/LunarVim/nvim-basic-ide.git ~/.config/nvim
	# Just in case lol
	mkdir ~/.config 2>/dev/null
	# "Plug" package manager
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	} && NVIM 

function FORENSICS() {
	echo -e "\n[*] Installing Forensics-all package" | tee -a errors.log
	sudo apt install -y forensics-all
}

function OBSIDIAN() {
	echo -e "\n[*] Installing Obsidian-notes" | tee -a errors.log
	wget "https://github.com/obsidianmd/obsidian-releases/releases/download/v0.14.6/obsidian_0.14.6_amd64.deb"
	chmod +x 'obsidian_0.14.6_amd64.deb'
	sudo dpkg -i ./'obsidian_0.14.6_amd64.deb'

} && OBSIDIAN 

function NOTES() {
	echo -e "\n[*] Installing MyNotes" | tee -a errors.log
	cd ~/Documents
	git clone https://github.com/zAbuQasem/MyNotes
	# Returning to the working directory
	cd $workingdir
} && NOTES

function K8S(){
	echo -e "\n[*] Installing Minikube" | tee -a errors.log
	wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	chmod +x minikube-linux-amd64
	sudo mv minikube-linux-amd64 /usr/local/bin/minikube
	curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
	chmod +x ./kubectl
	sudo mv ./kubectl /usr/local/bin/kubectl
} && K8S

function DISCORD() {
	echo -e "\n[*] Installing Discord" | tee -a errors.log
	wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
	sudo dpkg -i $workingdir/discord.deb
} && DISCORD 

function AWSCLI() {
	echo -e "\n[*] Installing AWS-CLI" | tee -a errors.log
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
} && AWSCLI 

function GHIDRA() {
	echo -e "\n[*] Installing Ghidra_10.1.3" | tee -a errors.log
	wget "https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.1.3_build/ghidra_10.1.3_PUBLIC_20220421.zip"
	unzip ghidra_10.1.3_PUBLIC_20220421.zip && mv ghidra_10.1.3_PUBLIC_20220421 ghidra && cp -r ghidra /usr/share
	wget "https://raw.githubusercontent.com/Crypto-Cat/CTF/main/auto_ghidra.py"
	chmod +x auto_ghidra.py
	sed -i '1s/^/#!\/usr\/bin\/env python3 \n/' auto_ghidra.py
	sudo mv auto_ghidra.py /usr/bin/auto_ghidra
} && GHIDRA 

function PWNDBG() {
	echo -e "\n[*] Installing Pwndbg" | tee -a errors.log
	git clone https://github.com/pwndbg/pwndbg
	cd pwndbg
	./setup.sh
	cd ..
	mv pwndbg ~/pwndbg-src
	echo "source ~/pwndbg-src/gdbinit.py" > ~/.gdbinit_pwndbg
	echo -e "define init-pwndbg\nsource ~/.gdbinit_pwndbg\nend\ndocument init-pwndbg\nInitializes PwnDBG\nend" > ~/.gdbinit
	echo "#!/bin/bash" > pwndbg ; echo -e 'exec gdb -q -ex init-pwndbg "$@"' >> pwndbg ; chmod +x pwndbg
	sudo mv pwndbg /usr/bin
	# Returning to the working directory
	cd $workingdir
} && PWNDBG 

function PYCHARM() {
	# Last function to call as it requires GUI interaction
	echo -e "\n[*] Installing Pycharm" | tee -a errors.log
	sudo snap install pycharm-community --classic
} && PYCHARM


function PYTHONLIBS(){
	echo -e "\n[*] Installing Python3 packages" | tee -a errors.log
	pip3 install --no-warn-script-location  updog trufflehog rich flask-unsign flask paramiko pyngrok
} && PYTHONLIBS


function I3(){
	echo -e "\n[*] Installing i3 desktop" | tee -a errors.log
	chmod +x "$basedir/i3config.sh"
	$basedir/i3config.sh
} && I3 

function MSTEAMS() {
	echo -e "\n[*] Installing Microsoft teams" | tee -a errors.log
	# Ensuring sudo pass again...
	sudo ls
	curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'
	sudo apt update -y && sudo apt install -y teams
} && MSTEAMS

function GITHUBDESKTOP(){
	echo -e "\n[*] Installing Github desktop" | tee -a errors.log
	wget https://github.com/shiftkey/desktop/releases/download/release-2.9.3-linux3/GitHubDesktop-linux-2.9.3-linux3.deb
	echo y | sudo gdebi GitHubDesktop-linux-2.9.3-linux3.deb
} && GITHUBDESKTOP

RUN() {
	# Later going to invoke functions and redirect errors to a file to reinstall manually or fix the script
	# shutdown -r (Invoke this command at the end to start a new life
	# Comment the below line to skip istalling more than 1000 mb of forensics tools
	#FORENSICS
	# Cleanups
	sudo apt-get clean
	sudo apt -y autoremove
	echo "[+] Finished the setup process, Please view ./errors.log in case of corruption"
	echo  -e "\033[5m---> Please restart your computer!\033[0m"
} && RUN
# TODO
# Install the apps that require appending a source file from snap if they are available
