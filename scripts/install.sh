#!/bin/bash

declare -a PKGS=(
    # Development
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

    # Personal
    "google-chrome"
    "spotify"
    "obs-studio"

    # OS
    # "hyprland" # Tiling Window Manager
    # "pipewire" # 
    # "wireplumber" #
    # "networkmanager"
    # "pulseaudio"
    # "libcamera"
    
    # OS Apps
    "neofetch" # System Info
    "btop" # A monitor of resources
    "libreoffice-still" # Office Suite
    "loupe" # Image Viewer (GNOME)
    "decibels" # Audio Player (GNOME)
    "impression" # Bootable Driver Generator (GNOME)
    "snapshot" # Camera App (GNOME)
    "gnome-clocks" # Clock App (GNOME)
)

# Install Yay
echo -e "$TAG_STATUS Looking for the \"yay\" package..."

if [[ $(which yay) != "which: no " ]]
then
    echo -e "$TAG_SKIP \"yay\" has been already installed."
else
    echo -e "$TAG_STATUS \"yay\" is not found. Installing \"yay\"..."

    sudo pacman -S --needed git base-devel yay

    # Check whether the installation is successful
    if [[ $(which yay) != "which: no " ]]
    then
        echo -e "$TAG_DONE Yay has been installed."
    else
        echo -e "$TAG_FAIL Yay is not installed. Stoping the script."
        exit -1
    fi
fi


# Update 
echo -e "$TAG_STATUS Updating packages..."
yay -Y --devel --save
yay -Syu

# Download Packages
echo -e "$TAG_STATUS Downloading packages..."

for PKG in "${PKGS[@]}"; do
    yay -S --needed $PKG

    echo -e "$TAG_DONE $PKG has been installed."
done
