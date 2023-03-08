# Ubuntu-NewLife
I'm writing this script because i hate re-installing everything manually and customizing the **** every time whenever i have to re-install ubuntu.

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
# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
# Install arsenal
python3 -m pip install arsenal-cli
# Install latest impacket-tools
git clone https://github.com/fortra/impacket
cd impacket 
pipx install .
# Scripts will be available without "impacket" prefix
```

## Change lockscreen image
```bash
sudo apt install libglib2.0-dev-bin -y
wget -qO - https://github.com/PRATAP-KUMAR/ubuntu-gdm-set-background/archive/main.tar.gz | tar zx --strip-components=1 ubuntu-gdm-set-background-main/ubuntu-gdm-set-background
# To change the image
sudo ./ubuntu-gdm-set-background --image /PATH
```
## Fix Vmware issues with ubuntu 22.04
```bash
chmod +x fix-vmware.sh
./fix-vmware.sh
```
# Useful Scripts:
- [Weaponize Kali](https://github.com/snovvcrash/WeaponizeKali.sh)
- [Install Volatility](https://pwnsec-notes.gitbook.io/ctf-notes/forensics/memory#installing-volatility)
- [f8x](https://github.com/ffffffff0x/f8x)
