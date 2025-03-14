#!/bin/bash
#Downloads newest discord .deb installation and installs it if current is outdated


#the flag --content-disposition used to get a properly named file instead of the the GET parameters as name
wget --content-disposition 'https://discordapp.com/api/download/stable?platform=linux&format=deb'
DSC_PATH=$(find . -name "discord*.deb")

if [ ! -f "$DSC_PATH" ]; then
    echo "Download failed or file not found. Exiting."
    exit 1
fi

CUR_VER=$(dpkg-query -W -f='${Version}' "discord")

if [ -z "$CUR_VER" ]; then
        echo "Discord does not appear to be installed on this device"
        read -p "Proceed with installation? (y/n): " response
        case $response in
                [yY] | [yY][eE][sS])
                        echo "Proceeding with installation of $DSC_PATH"
                        sudo dpkg -i "$DSC_PATH"
                        rm "$DSC_PATH"
                        exit 0
                        ;;

                *)
                        echo "Deleting $DSC_PATH and exiting"
                        rm "$DSC_PATH"
                        exit 0
                        ;;
        esac
fi

NEW_VER=$(basename "$DSC_PATH" | sed -n 's/^[^-]*-\([^-]*\)\.deb$/\1/p')
if [ -z "$NEW_VER" ]; then
        echo "Failed to get Version from: $DSC_PATH"
	echo "Check  file name"
	exit 1
fi

if dpkg --compare-versions "$CUR_VER" "lt" "$NEW_VER"; then
        echo "Proceeding to install discord-$NEW_VER.deb given version $CUR_VER"
else
        echo "Current Version $CUR_VER is newer than or equal to downloaded .deb: $NEW_VER"
        echo "Deleting $DSC_PATH"
	rm "$DSC_PATH"
	exit 1
fi
sudo dpkg -i "$DSC_PATH"
rm "$DSC_PATH"
