#!/bin/bash
# Script to update Discord on Debian-based systems

CUR_VER=$(dpkg-query -W -f='${Version}' "discord")
NEW_VER=$(curl  -sI 'https://discordapp.com/api/download/stable?platform=linux&format=deb' | grep -i location | sed 's/.*discord-\(.*\)\.deb/\1/g')

install() {
#the flag --content-disposition used to get a properly named file instead of the the GET parameters as name
        wget --content-disposition 'https://discordapp.com/api/download/stable?platform=linux&format=deb'
        DSC_PATH=$(find . -maxdepth 1 -name "discord*.deb")
        if [ ! -f "$DSC_PATH" ]; then
                echo "Download failed or file not found (maybe you have multiple discord.deb files in PWD?)."
                exit 1
        fi
        sudo dpkg -i "$DSC_PATH"
        rm "$DSC_PATH"
}

if [ -z "$NEW_VER" ]; then
        echo "Failed to get version from discordapp.net: $DSC_PATH"
        exit 1
fi

if [ -z "$CUR_VER" ]; then
        echo "Discord does not appear to be installed on this device"
        install
        exec discord
fi

if dpkg --compare-versions "$CUR_VER" "lt" "$NEW_VER"; then
        echo "Proceeding to update discord to version $NEW_VER from $CUR_VER"
else
        echo "Current Version $CUR_VER is newer than or equal to downloaded .deb: $NEW_VER"
        exec discord
fi

install
exec discord