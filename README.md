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
 ```bash
echo -e "\n[*] Installing OhMyZsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Run below commands to install my zshrc file....
wget https://raw.githubusercontent.com/zAbuQasem/Misc/main/zshrc
sed -i "s/<HOME>/$USER/g" "./zshrc"
mv zshrc ~/.zshrc
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
