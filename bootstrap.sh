#!/bin/bash

remove_flag="";

dots_dir="$(dirname "$(realpath "$0")")";

cfg_dir="$HOME/.config"

# Link the dotfiles
declare -A dst=(
    [".gitconfig"]="$HOME"
    [".tmux.conf"]="$HOME"
    ["nvim"]="$cfg_dir"
    ["ghostty"]="$cfg_dir"
    ["scripts"]="$HOME"
)


# Interpret the flags
while getopts "r" flag; do
    case "${flag}" in
        r) remove_flag=true;;
        *);;
    esac
done

for src in "${!dst[@]}"
do
    to="${dst[$src]}/$src"

    if [[ $remove_flag ]]; then
        echo "Removing the link form $to"
        rm "$to"
    else
        from="$dots_dir/$src"
        echo "Linking $from to $to"
        ln -s "$from" "$to"
    fi
done

