#!/bin/bash

# List of paths to add symbolic links to
declare -A symlinks=(
    [".gitconfig"]="$HOME"
    [".xbindkeysrc"]="$HOME"
    [".tmux.conf"]="$HOME"
    ["nvim"]="$HOME/.config"
    ["alacritty"]="$HOME/.config"
    ["fish"]="$HOME/.config"
    ["hypr"]="$HOME/.config"
    ["waybar"]="$HOME/.config"
    ["waypaper"]="$HOME/.config"
)

link_src symlinks
