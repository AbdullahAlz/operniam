#!/bin/bash
# Set Up Debian
# This script is intended to be used on a fresh Debian installation to install some basic tools and applications

set -e 
installed_packages=()

log() {
    echo -e "\e[1;34m[$1]\e[0m $2"
}
warn () {
    echo -e "\e[1;31m[WARN]\e[0m $1"
}
ask() {
    echo -e "\e[1;32m[ASK]\e[0m $1"
}

installpkg() {
    sudo apt install -y "$1" && installed_packages+=("$1")
}

log "INFO" "Installing Terminator"
installpkg terminator

log "INFO" "Installing git and Czsh from Samastek"
sudo apt update
sudo apt upgrade -y
installpkg git

cd ~
mkdir workspace
git clone https://github.com/samastek/czsh.git
git clone https://github.com/AbdullahAlz/operniam.git
cd czsh
./install.sh

sudo chsh -s /bin/zsh

log "INFO" "Installing java, maven, python3 and other tools"

installpkg openjdk-17-jdk
installpkg curl
installpkg wget
installpkg micro
installpkg htop
installpkg neofetch
installpkg moreutils
installpkg p7zip-full
installpkg maven
installpkg tree
installpkg autoconf
installpkg libncurses-dev
installpkg python3
installpkg python3-pip
installpkg python3-venv
installpkg openssh-client
installpkg software-properties-common

log "INFO" "Installing Applications: VLC, Thunderbird, Telegram, Brave Browser"
installpkg vlc
installpkg thunderbird
installpkg telegram-desktop

log "INFO" "Installing VSCode"
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

installpkg apt-transport-https
sudo apt update
installpkg code

ask "Do you want to install Brave Browser? (y/n)"
read -r answer
if [ "$answer" == "y" ]; then
    curl -fsS https://dl.brave.com/install.sh | sh
    installed_packages+=("brave-browser")
fi

ask "Do you want to install Discord [Experimental]? (y/n)"
read -r answer
if [ "$answer" == "y" ]; then
    cd ~/workspace/operniam
    sudo ./updtdsc.sh
    installed_packages+=("discord")
    cp updtdsc.sh ~/.local/bin/updtdsc && chmod +x ~/.local/bin/updtdsc
    log "INFO" "Discord has been installed. You can update it by running 'updtdsc' in the terminal"
fi

log "INFO" "Installing Nvidia Drivers"
warn "Proceeding will add contrib and non-free repositories to your sources.list to install proprietary Nvidia drivers"
ask "Do you want to proceed? (y/n)"
read -r answer
if [ "$answer" == "y" ]; then
    installpkg nvidia-driver
    installpkg nvidia-settings

    log "INFO" "Blacklisting Nouveau"
    echo -e "blacklist nouveau\noptions nouveau modeset=0" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf > /dev/null
    sudo update-initramfs -u
    warn "Please reboot your system to apply changes"
    warn "Make sure you added nomodeset to your grub configuration in /etc/default/grub"
fi


log "DONE" "Following packages were installed:"
printf "\e[1;32m%s\n\e[0m" "${installed_packages[@]}"