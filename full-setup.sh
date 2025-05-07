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

if [ "$SUDO_USER" ]; then
  USER_HOME=$(eval echo "~$SUDO_USER")
else
  USER_HOME="$HOME"
fi

log "INFO" "Installing Terminator"
installpkg terminator
installpkg git

log "INFO" "Installing Open-JDK 17, maven, python3 and other tools"

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

log "INFO" "Attempting to install Nvidia Drivers:"
warn "To proceed, you HAVE to have contrib and non-free repositories enabled in your /etc/apt/sources.list"
log "INFO" "You can perform these changes in /etc/apt/sources.list on another terminal and then proceed"
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
    
    ask "Do you want to install Steam? (y/n)"
    read -r answer
    if [ "$answer" == "y" ]; then
        sudo dpkg --add-architecture i386
        sudo apt update
        installpkg libc6:i386
        installpkg libgl1-mesa-dri:i386
        installpkg libgl1-mesa-glx:i386
        installpkg libgl1-nvidia-glvnd-glx
        installpkg nvidia-driver-libs:i386
        installpkg steam
        log "INFO" "Steam has been installed"
    fi
fi

log "INFO" "Installing Discord"
    wget --content-disposition 'https://discordapp.com/api/download/stable?platform=linux&format=deb'
    DSC_PATH=$(find . -maxdepth 1 -name "discord*.deb")

    if [ ! -f "$DSC_PATH" ]; then
        echo "Download failed or file not found (maybe you have multiple discord.deb files in PWD?)."
        exit 1
    fi
    sudo dpkg -i "$DSC_PATH"
    rm "$DSC_PATH"

log "DONE" "Following packages were installed:"
printf "\e[1;32m%s\n\e[0m" "${installed_packages[@]}"