#!/bin/bash

# Variables
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
echo yes | sudo add-apt-repository ppa:webupd8team/atom # atom
echo yes | sudo add-apt-repository ppa:ubuntuhandbook1/audacity # audacity
echo yes | sudo add-apt-repository ppa:eugenesan/ppa # caffeine
echo yes | sudo add-apt-repository ppa:webupd8team/indicator-kedeconnect # KDE connect
echo yes | sudo add-apt-repository ppa:obsproject/obs-studio # OBS-Studio screen recorder
sudo apt update -y 

# Installing alot of things
sudo apt install -y build-essential linux-headers-generic dirmngr gnupg apt-transport-https ca-certificates software-properties-common vim git curl wget python-dev python-pip python3-dev python3-pip python3-venv p7zip-full zip unzip netutils gdebi snapd openssh-server vsftpd samba sqlite3 default-jre gdb strace ltrace imagemagick gimp vlc qtwayland5 synaptic audacity telegram-desktop caffeine gnome-shell-extension-weather atril kdeconnect indicator-kdeconnect qtqr obs-studio flameshot chromium-browser wireshark

# Installing ngrok
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok -y
# Installing vmware latest version
function VMWARE() {
	echo -e "\n[*]Installing VmWare" | tee errors.log
	wget --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0" https://www.vmware.com/go/getplayer-linux
	chmod +x getplayer-linux
	sudo ./getplayer-linux --required --eulas-agreed
	echo "[!] If you faced issues due to kernel update: https://communities.vmware.com/t5/VMware-Workstation-Pro/VMware-16-2-3-not-working-on-Ubuntu-22-04-LTS/td-p/2905535"
} && VMWARE 2 >> ./errors.log

function SUBLIMETEXT4() {
	echo -e "\n[*] Installing SublimeText-4" | tee errors.log
	curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
	sudo apt update -y && sudo apt -y install sublime-text
} && SUBLIMETEXT4 2 >> ./errors.log 

function OHMYZSH() {
	echo -e "\n[*] Installing OhMyZsh" | tee errors.log
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	wget https://raw.githubusercontent.com/zAbuQasem/Misc/main/zshrc
	sed -i "s/<HOME>/$USER/g" "./zshrc"
	mv zshrc ~/.zshrc
} && OHMYZSH 2 >> ./errors.log

function TMUX() {
	echo -e "\n[*] Installing Tmux" | tee errors.log
	sudo apt install -y tmux
	curl https://raw.githubusercontent.com/zAbuQasem/Misc/main/tmux.conf -o ~/.tmux.conf
	# "tpm" plugin manager
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
} && TMUX 2 >> ./errors.log

function VSCODE() {
	echo -e "\n[*] Installing VScode" | tee errors.log
	sudo apt install -y software-properties-common apt-transport-https wget
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
	sudo apt install -y code
} && VSCODE 2 >> ./errors.log

function NVIM() {
	echo -e "\n[*] Installing NeoVim" | tee errors.log
	sudo apt-get install neovim
	wget https://github.com/zAbuQasem/Misc/raw/main/nvim.zip
	# Just in case lol
	mkdir ~/.config 2>/dev/null
	/usr/bin/unzip nvim.zip –d ~/.config
	# "Plug" package manager
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	} && NVIM 2 >> ./errors.log

function FORENSICS() {
	echo -e "\n[*] Installing Forensics-all package" | tee errors.log
	sudo apt install -y forensics-all
}

function OBSIDIAN() {
	echo -e "\n[*] Installing Obsidian-notes" | tee errors.log
	wget "https://github.com/obsidianmd/obsidian-releases/releases/download/v0.14.6/Obsidian-0.14.6.AppImage"
	sudo mv "./Obsidian-0.14.6.AppImage" /usr/local/bin/obsidian
} && OBSIDIAN 2 >> ./errors.log

function NOTES() {
	echo -e "\n[*] Installing MyNotes" | tee errors.log
	cd ~/Documents
	git clone https://github.com/zAbuQasem/MyNotes
	# Returning to the working directory
	cd $workingdir
} && NOTES 2 >> ./errors.log

function DISCORD() {
	echo -e "\n[*] Installing Discord" | tee errors.log
	wget "https://discord.com/api/download?platform=linux&format=deb"
	sudo apt install "download?platform=linux&format=deb"
} && DISCORD 2 >> ./errors.log

function AWSCLI() {
	echo -e "\n[*] Installing AWS-CLI" | tee errors.log
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
} && AWSCLI 2 >> ./errors.log

function GHIDRA() {
	echo -e "\n[*] Installing Ghidra_10.1.3" | tee errors.log
	wget "https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.1.3_build/ghidra_10.1.3_PUBLIC_20220421.zip"
	unzip ghidra_10.1.3_PUBLIC_20220421.zip && mv ghidra_10.1.3_PUBLIC_20220421 ghidra && cp -r ghidra /usr/share
	wget "https://raw.githubusercontent.com/Crypto-Cat/CTF/main/auto_ghidra.py"
	chmod +x auto_ghidra.py
	sed -i '1s/^/#!\/usr\/bin\/env python3 \n/' auto_ghidra.py
	sudo mv auto_ghidra.py /usr/bin/auto_ghidra
} && GHIDRA 2 >> ./errors.log

function PWNDBG() {
	echo -e "\n[*] Installing Pwndbg" | tee errors.log
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
} && PWNDBG 2 >> ./errors.log

function PYCHARM() {
	# Last function to call as it requires GUI interaction
	echo -e "\n[*] Installing Pycharm" | tee errors.log
	curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh
	chmod +x jetbrains-toolbox.sh
	sudo ./jetbrains-toolbox.sh
}

function I3(){
	echo -e "\n[*] Installing i3 desktop" | tee errors.log
	chmod +x "./i3config.sh"
	./i3config.sh
} && I3 2 >> ./errors.log

RUN() {
	# Later going to invoke functions and redirect errors to a file to reinstall manually or fix the script
	# shutdown -r (Invoke this command at the end to start a new life
	# Callig pycharm from here, because it requires some GUI interaction, make sure to comment bellow line when runnnig the script remotely!
	PYCHARM
	# Comment the below line to skip istalling more than 1000 mb of forensics tools
	#FORENSICS
	echo "[+] Finished the setup process, Please view ./errors.log in case of corruption"
	echo  -e "\033[5mPlease restart your computer!\033[0m"
}
