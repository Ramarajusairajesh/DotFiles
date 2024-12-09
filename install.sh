#!/bin/bash
MESSAGE="Read the source before running"

# Create the banner
echo "###########################################"
echo "#                                         #"
printf "#  %-36s #\n" "$MESSAGE"
echo "#                                         #"
echo "###########################################"

EXTENSIONS=(
    "pifalnbglchfojkfmechjalgbjoodlpg" #dark reader extensio
    "eimadpbcbfnmbkopoojfekhnkhdbieeh"
    "gioehmkjkeamcinbdelehlpnpdcdjpdp"
    "fdpohaocaechififmbbbbbknoalclacl"
    "cimiefiiaegbelhefglklhhakcgmhkai"
    "jfiihjeimjpkpoaekpdpllpaeichkiod"
    "hfjbmagddngcpeloejdejnfgbamkjaeg"
)

if [ "$(id -u)" -ne 0]; then 
  echo -e "\033[0;32m Lacking root previllege ! Run this script either with sudo or as root !\033[0m"
  exit 1
fi

apt install curl
cd ~/Downloads/

echo "Installing browser,text editors and other stufs"

curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list
apt update
apt install brave-browser-archive-keyring

apt install fish nodejs npm python3-venv python3-django golang gcc gdb g++ libvirt qemu terminator
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
rm -rf /opt/nvim
tar -C /opt -xzf nvim-linux64.tar.gz
git clone https://github.com/LazyVim/starter ~/.config/nvim

cp -rf ./fish ~/.config/fish 

git cp ./nvim/init.lua ~/.config/nvim/init.lua
cp ./nvim/lua ~/.config/nvim/lua -rf

echo " Installing virutamanager along with qemu "

apt install  qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager qemu-efi-aarch64 qemu-efi-arm  qemu-efi-riscv64 qemu-kvm qemu-system-x86  qemu-system-arm qemu-system-common

echo " Do you want to create windows virtual machine "
read flag

if $flag;then 
  echo "Download the iso from the official microsoft website and press enter"
  read 
  windows_iso=$(find . -iname "windows*" -type f)
  if [[ -n "$windows_iso" ]]; then
    qemu-system-x86_64 -m 4G cpu host \
    -smp 2,cores=2,threads=2 \
    -boot d \
    -cdrom "$windows_iso" \
    -hda windows.qcow2 \
    -vga std \
    -display gtk \
    -usbdevice tablet \
    -device usb-tablet \
    -soundhw all,coreaudio \
    -enable-kvm \
    -bios qemu-bios.bin \
    -bios_prefix /usr/share/qemu/BIOS/ \
    -machine q35 \
    -device ich9-usb-uhci1 \
    -device ich9-usb-ehci1 device ich9-usb-xhci1elseecho


  else
  commandecho "No Windows ISO found in the current download directory abording window vm creation"
fi

echo "Installing flatpak"
apt install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "installing gpu recorder and zen browser"
flatpak install flathub com.dec05eba.gpu_screen_recorder
flatpak install flathub io.github.zen_browser.zen
flatpak install flathub com.heroicgameslauncher.hgl

cp ./keyboard.kksrc ~/.config/kglobalshortcutsrc

echo " Terminal titlebar and frame editor only avilable via settings apps! Follow the processure"
echo "This only works for KDE! Open settings , go to Color & Themens >> Windows Decorator and click on the pencil icon on breeze"
echo "Go to Window-specify overrides and click (Add +) button"
echo "set macthing window property to Windows Class Name and Regualr expression to match to \"terminator\" "
echo "Under decorator check both Boarder Size and hide title bar and for boreder size: Choose no border"
echo "Do the same for konsole add \"konsole\" for the regular expression window search "

echo "Do you want to add extension to brave?"
read response
if $response;then
  echo " Installing chrome extensions via cli is finiky if this doesn't work try manual installation"
  EXT_DIR="$HOME/.config/BraveSoftware/Brave-Browser/Default/Extensions"
  mkdir -p "$EXT_DIR"
  
  # Install extensions
  echo "Installing chrome extensions via cli is finiky so if this doesn't work comment this session and add the extensions manually yourself"
  for ID in "${EXTENSIONS[@]}"; do
      URL="https://clients2.google.com/service/update2/crx?response=redirect&prodversion=96.0&x=id%3D${ID}%26installsource%3Dondemand%26uc"
      DEST="$EXT_DIR/$ID"
      mkdir -p "$DEST" && wget -q "$URL" -O temp.crx && unzip -q temp.crx -d "$DEST" && rm -f temp.crx
      echo "Installed extension: $ID"
  done
  
  echo "Extensions installed. Restart Brave to apply changes."

#If environment varialbles for these doesn't added add these manually
#fish_add_path /opt/nvim-linux64/bin/
#fish_add_path ~/.cargo 
echo "Installing docker"
apt install docker.io docker-compose docker-registry
echo "Insatlling docker"
sudo usermod -aG docker $USER



#If the group doesn't solve you non root docker issue try manually checking the groups and add it if it still persist run the follow commands

#apt install -y uidmap dbus-user-session
#curl -fsSL https://get.docker.com | sh
#dockerd-rootless-setuptool.sh install
apt install distrobox
distrobox create -i kalilinux/kali-rolling -n kali
distrobox create -i archlinux -n arch
apt install winetricks wine64* 

echo "Does your system have NVIDIA GPU (Y) Or (N)"
read GPU
if [[$GPU =="Y"]]; then
	echo "Installing the latest NVIDIA driver"
	$(apt search nvidia-driver | grep open | grep -v -e "server" -e "headless" | grep -E '[0-9]' | tail -n 1 | cut -d '/' -f | xargs apt install -y)
fi
reboot -f
