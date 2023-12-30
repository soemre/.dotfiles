#!/bin/bash

# List of paths to add symbolic links to
declare -A SYMLINKS=(
    [".gitconfig"]="$HOME"
    [".xbindkeysrc"]="$HOME"
    ["nvim"]="$HOME/.config"
    ["alacritty"]="$HOME/.config"
    ["fish"]="$HOME/.config"
    ["hypr"]="$HOME/.config"
)

# Adds symbolic links to given directories
echo -e "$TAG_STATUS Linking the config files..."

for FROM_PATH in "${!SYMLINKS[@]}"; do

    TO_PATH="${SYMLINKS["$FROM_PATH"]}/$FROM_PATH";

    # Skip existing paths
    if [ -L $TO_PATH ]; then
        echo -e "$TAG_SKIP $FROM_PATH is already linked to $TO_PATH";
        continue;
    fi

    ln -s "$ABSOLUTE_PATH/$SRC_DIR/$FROM_PATH" "$TO_PATH";
    echo -e "$TAG_DONE $TO_PATH to $FROM_PATH";

done
