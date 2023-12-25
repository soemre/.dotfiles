#!/bin/bash

declare -a PKGS_DEV=(
    "git"
    "neovim"
    "fish"
    "oh-my-fish"
    "alacritty-git"
    "rust"
    "flutter"
    "android-studio"
    "ttf-firacode-nerd"
    "fzf"
)

declare -a PKGS_PERS=(
    "google-chrome"
    "spotify"
)

declare -a PKGS_OS=(

    "btop"
)

# Install Yay
pacman -S --needed git base-devel yay

# Update Packages
yay -Y --devel --save
yay -Syu

# Download Packages
for pkg in PKGS_DEV; do
    yay -S --needed $pkg
done

for pkg in PKGS_PERS; do
    yay -S --needed $pkg
done

for pkg in PKGS_OS; do
    yay -S --needed $pkg
done
