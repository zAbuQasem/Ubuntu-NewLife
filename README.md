# Compability
Tested on Ubuntu:20.04->22.04, blackbuntu:22.04, kali-linux
# Usage
```bash
git clone https://github.com/zAbuQasem/Ubuntu-NewLife.git
cd Ubuntu-NewLife
chmod +x Setup.sh
./Setup.sh
```
## OHMYZSH installation
 Enusre that zsh is already installed! (`sudo apt install -y zsh`)
 ```bash
echo -e "\n[*] Installing OhMyZsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# Run below commands to install my zshrc file....
wget https://raw.githubusercontent.com/zAbuQasem/Misc/main/zshrc
sed -i "s/<HOME>/$USER/g" "./zshrc"
mv zshrc ~/.zshrc
```
# Extras
```sh
# Feroxbuster
curl -sL https://raw.githubusercontent.com/epi052/feroxbuster/master/install-nix.sh | bash

# FFUF
go install github.com/ffuf/ffuf/v2@latest

# AD tools
pipx install -f "git+https://github.com/fox-it/BloodHound.py.git"
pipx install -f "git+https://github.com/ly4k/Certipy.git"
pipx install -f "git+https://github.com/p0dalirius/Coercer.git"
pipx install -f "git+https://github.com/Porchetta-Industries/CrackMapExec.git"
pipx install -f "git+https://github.com/snovvcrash/DivideAndScan.git"
pipx install man-spider
pipx install -f "git+https://github.com/Z4kSec/Masky"
pipx install -f "git+https://github.com/Hackndo/WebclientServiceScanner.git"
pipx install -f "git+https://github.com/fox-it/aclpwn.py.git"
pipx install -f "git+https://github.com/dirkjanm/adidnsdump.git"
pipx install -f "git+https://github.com/fox-it/bloodhound-import.git"
pipx install -f "git+https://github.com/zer1t0/certi.git"
pipx install -f "git+https://github.com/zblurx/certsync.git"
pipx install -f "git+https://github.com/galkan/crowbar.git"
pipx install -f "git+https://github.com/zblurx/dploot.git"
pipx install -f "git+https://github.com/cddmp/enum4linux-ng.git"
pipx install -f "git+https://github.com/fortra/impacket.git"
pipx install -f "git+https://github.com/franc-pentest/ldeep.git"
pipx install -f "git+https://github.com/Hackndo/lsassy.git"
pipx install -f "git+https://github.com/fox-it/mitm6.git"
pipx install -f "git+https://github.com/garrettfoster13/pre2k.git"
pipx install -f "git+https://github.com/skelsec/pypykatz.git"
pipx install -f "git+https://github.com/Tw1sm/RITM.git"
pipx install -f "git+https://github.com/sc0tfree/updog.git"

# Install vulscan nmap scripts
#https://github.com/scipag/vulscan
git clone https://github.com/scipag/vulscan scipag_vulscan
ln -s `pwd`/scipag_vulscan /usr/share/nmap/scripts/vulscan    
```

## Change lockscreen image
```bash
sudo apt install libglib2.0-dev-bin -y
wget -qO - https://github.com/PRATAP-KUMAR/ubuntu-gdm-set-background/archive/main.tar.gz | tar zx --strip-components=1 ubuntu-gdm-set-background-main/ubuntu-gdm-set-background
## To change the image
sudo ./ubuntu-gdm-set-background --image /PATH
```
## Fix Vmware issues with ubuntu 22.04
```bash
chmod +x fix-vmware.sh
./fix-vmware.sh
```
## Prevent Auto Kernel upgrade
```bash
sudo apt-mark hold linux-image-$(uname -r)
```
# Useful Scripts:
- [Weaponize Kali](https://github.com/snovvcrash/WeaponizeKali.sh)
- [Install Volatility](https://pwnsec-notes.gitbook.io/ctf-notes/forensics/memory#installing-volatility)
- [f8x](https://github.com/ffffffff0x/f8x)
# TODO 
Convert this to ansible
