#!/bin/bash

# Config
readonly ABSOLUTE_PATH=$(realpath $(dirname $0))
readonly SRC_DIR="src";

readonly TAG_SKIP="SKIPPING";
readonly TAG_EXCEPTION="FAILED";
readonly TAG_DONE="DONE";


# List of paths to add symbolic links to
declare -A symlink_paths=(
    [".gitconfig"]="$HOME"
    ["nvim"]="$HOME/.config"
    ["alacritty"]="$HOME/.config"
)

# Adds symbolic links to given directories
for from_path in "${!symlink_paths[@]}"; do

    to_path="${symlink_paths["${from_path}"]}/${from_path}";

    # Skip existing paths
    if [ -L ${to_path} ]; then
        echo "[${TAG_SKIP}] ${from_path} is already linked to ${to_path}";
        continue;
    fi

    ln -s "${ABSOLUTE_PATH}/${SRC_DIR}/${from_path}" "${to_path}";
    echo "[${TAG_DONE}] ${to_path} to ${from_path}";

done
