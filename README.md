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
 ```
echo -e "\n[*] Installing OhMyZsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
wget https://raw.githubusercontent.com/zAbuQasem/Misc/main/zshrc
sed -i "s/<HOME>/$USER/g" "./zshrc"
mv zshrc ~/.zshrc
```
