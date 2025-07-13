#!/bin/bash
set -e

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 partition_image directory_inode"
    echo "Example: $0 p34821-25 2"
    exit 1
fi

mkdir -p "output"

copy_dir() {
    local img=$1
    local inode=$2
    local out_path=$3
    
    mkdir -p "$out_path"
    local entries

    if ! IFS=$'\n' read -rd '' -a entries < <(fls "$img" "$inode" 2>/dev/null && printf '\0'); then
        echo "Warning: Could not read directory inode $inode"
        return
    fi

    if [[ ${#entries[@]} -eq 0 ]]; then
        echo "No entries found in inode $inode"
        return
    fi

    for entry in "${entries[@]}"; do
        if [[ -z "$entry" ]]; then
            continue
        fi
                
        local type=$(echo "$entry" | awk '{print $1}')

        # (-/-) means deleted entry
        if [[ "$type" == "-/-" ]]; then
            echo "Skipping deleted entry: $entry"
            continue
        fi
        
        local entry_inode=$(echo "$entry" | awk '{print $2}' | tr -d ':')
        local name=$(echo "$entry" | awk '{for(i=3;i<=NF;i++) printf "%s%s", $i, (i<NF?" ":"");}')

        if [[ "$name" == "." || "$name" == ".." ]]; then
            continue
        fi

        # (d/d) means directory
        if [[ "$type" == d/d ]]; then
            copy_dir "$img" "$entry_inode" "$out_path/$name"
        else
            if ! icat "$img" "$entry_inode" > "$out_path/$name" 2>/dev/null; then
                echo "Warning: Failed to extract $name (inode: $entry_inode)"
            fi
        fi
    done
}

echo "Starting from inode $2 in $1"
copy_dir "$1" "$2" "output"
echo -e "\e[1;34m[DONE]"