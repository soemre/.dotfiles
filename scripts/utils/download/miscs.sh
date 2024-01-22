#!/bin/bash

download_miscs() {
    echo -e "$TAG_STATUS Downloading miscs..."

    local -n miscs="$1"
    local misc_path="${ABSOLUTE_PATH}/misc"

    if ! [ -d "$misc_path"  ]; then
        mkdir "$misc_path"
        echo -e "$TAG_DONE Created: $misc_path"
    fi

    for misc in "${!miscs[@]}"; do
        readonly dest="${misc_path}/$misc";

        if [ -f $dest ]; then
            echo -e "$TAG_SKIP $misc is already installed."
            continue
        fi

        readonly url="${miscs[$misc]}"
        echo -e "$TAG_STATUS Downloading $misc from $url..."

        curl -o "$dest" "$url" &> $LOG_FILE

        if ! [ -f $dest ]; then
            echo -e "$TAG_FAIL Couldn't download $misc"
            continue
        fi

        echo -e "$TAG_DONE $misc has been installed."
    done
}
