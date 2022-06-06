cd /usr/lib/vmware/modules/source
sudo git clone https://github.com/mkubecek/vmware-host-modules
cd vmware-host-modules
git config --global --add safe.directory /usr/lib/vmware/modules/source/vmware-host-modules
sudo git checkout workstation-16.2.3
sudo make
sudo tar -cf vmnet.tar vmnet-only
sudo tar -cf vmmon.tar vmmon-only
sudo mv vmnet.tar /usr/lib/vmware/modules/source/
sudo mv vmmon.tar /usr/lib/vmware/modules/source/
sudo vmware-modconfig --console --install-all
