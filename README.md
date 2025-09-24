# Compability
Tested on Ubuntu:20.04->22.04, blackbuntu:22.04
## Usage
```bash
git clone https://github.com/zAbuQasem/Ubuntu-NewLife.git
cd Ubuntu-NewLife
./setup.sh
```
## OHMYZSH installation
 ```bash
echo -e "\n[*] Installing OhMyZsh"
sudo apt install -y zsh
curl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o /tmp/install.sh &&
    sed -i 's/CHSH=no/CHSH=yes/g' /tmp/install.sh &&
    echo "Y" | sh /tmp/install.sh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# Run below commands to install my zshrc file....
curl -o zshrc https://raw.githubusercontent.com/zAbuQasem/Ubuntu-NewLife/refs/heads/main/.zshrc
mv zshrc ~/.zshrc
```
## Extras
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

---

## i3 Window Manager Key Bindings

`$mod` = Super (Windows) key

### Window & Layout Control
| Shortcut | Action |
|----------|--------|
| $mod+Return | Open terminal (Alacritty) |
| $mod+Shift+q | Close focused window |
| $mod+d | Application launcher (rofi) |
| $mod+Tab | Window switcher (rofi window mode) |
| $mod+Shift+space | Toggle floating / tiling |
| $mod+space | Toggle focus between tiling / floating |
| $mod+f | Fullscreen toggle |
| $mod+s | Stacked layout |
| $mod+w | Tabbed layout |
| $mod+e | Toggle split layout |
| $mod+a | Focus parent container |

### Focus / Movement
| Shortcut | Action |
|----------|--------|
| $mod+Left / Down / Up / Right | Move focus |
| $mod+Shift+Left / Down / Up / Right | Move window |

### Workspaces
| Shortcut | Action |
|----------|--------|
| $mod+1..5 (or more if configured) | Switch to workspace 1..5 |
| $mod+Shift+1..5 | Move window to workspace 1..5 |

### Resize Mode (Enter with $mod+r)
| Shortcut (in resize mode) | Action |
|---------------------------|--------|
| Left / Down / Up / Right | Grow/shrink width/height |
| Return / Escape | Exit resize mode |

### System & Session
| Shortcut | Action |
|----------|--------|
| $mod+Shift+c | Reload i3 config |
| $mod+Shift+r | Restart i3 |
| $mod+Shift+e | Exit i3 session |
| $mod+BackSpace | System menu (lock/logout/suspend/hibernate/reboot/shutdown) |
| XF86MonBrightnessUp / Down | Adjust screen brightness |
| $mod+P | Screenshot (flameshot) |
| Alt+Shift | Toggle English/Arabic keyboard layout |

### Display & Utilities
| Shortcut | Action |
|----------|--------|
| $mod+m | Open arandr (display configuration) |

> Clipboard: `$mod+v` launches Rofi clipboard (greenclip). Add/remove additional workspaces or bindings in `~/.config/i3/config`.

