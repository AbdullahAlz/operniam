#!/bin/bash
# Script to update Discord on Debian-based systems

log() {
    echo -e "\e[1;34m[$1]\e[0m $2"
}
warn () {
    echo -e "\e[1;33m[WARNING]\e[0m $1"
}
error() {
    echo -e "\e[1;31m[ERROR]\e[0m $1"
}

CUR_VER=$(dpkg-query -W -f='${Version}' "discord")
#New versions have $'\r' in the name, had to modify 
NEW_VER=$(curl  -sI 'https://discordapp.com/api/download/stable?platform=linux&format=deb' | grep -i location | sed 's/.*discord-\(.*\)\.deb/\1/g' | tr -d '\r' | tr -d '$')

install() {
#the flag --content-disposition used to get a properly named file instead of the the GET parameters as name
        wget --content-disposition 'https://discordapp.com/api/download/stable?platform=linux&format=deb'
        DSC_PATH=$(find . -maxdepth 1 -name "discord*.deb")
        if [ ! -f "$DSC_PATH" ]; then
                error "Download failed or file not found (maybe you have multiple discord.deb files in PWD?)."
                exit 1
        fi
        sudo dpkg -i "$DSC_PATH"
        rm "$DSC_PATH"
}

if [ -z "$NEW_VER" ]; then
        error "Failed to get version from discordapp.net: $DSC_PATH"
        exit 1
fi

if [ -z "$CUR_VER" ]; then
        log "INFO" "Discord does not appear to be installed on this device, installing"
        install
        exit 0
fi

if dpkg --compare-versions "$CUR_VER" "lt" "$NEW_VER"; then
        log "INFO" "Proceeding to update discord to version $NEW_VER from $CUR_VER"
        install
        exit 0
else
        warn "Current Version, $CUR_VER, is newer than or equal to downloaded .deb: $NEW_VER, exiting"
        exit 0
fi
error "Failed, check output above"
exit 1