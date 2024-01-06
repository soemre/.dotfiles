#!/bin/bash

declare -A MISCS=(
    ["default_wallpaper.jpg"]="https://r4.wallpaperflare.com/wallpaper/100/888/927/digital-digital-art-artwork-illustration-drawing-hd-wallpaper-015f5b840a55bda367fa9cca6e4c4608.jpg"
)

echo -e "$TAG_STATUS Downloading miscs..."

readonly misc_path="${ABSOLUTE_PATH}/misc"

if ! [ -d "$misc_path"  ]; then
    mkdir "$misc_path"
    echo -e "$TAG_DONE Created: $misc_path"
fi

for MISC in "${!MISCS[@]}"; do
    readonly dest="${misc_path}/$MISC";

    if [ -f $dest ]; then
        echo -e "$TAG_SKIP $MISC is already installed."
        continue
    fi

    readonly url="${MISCS[$MISC]}"
    echo -e "$TAG_STATUS Downloading $MISC from $url..."

    curl -o "$dest" "$url" &> $LOG_FILE

    if ! [ -f $dest ]; then
        echo -e "$TAG_FAIL Couldn't download $MISC"
        continue
    fi

    echo -e "$TAG_DONE $MISC has been installed."
done
