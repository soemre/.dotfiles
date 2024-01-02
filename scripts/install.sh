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
    # "networkmanager"
    "hyprland" # Tiling Window Manager
    "pipewire" # Hardware Server 
    "pulseaudio" # Audio Server
    "wireplumber" 
    "libcamera"
    "pamixer"
    "playerctl"
    "brightnessctl"
    
    # System Utils
    "neofetch" # System Info
    "btop" # A monitor of resources
    "nautilus" # File Manager (GNOME)
    "gnome-disk-utility" # Disk Util (GNOME)

    # Drivers
    "nvidia-settings" # Nvidia driver

    # Other Utils
    "gnome-clocks" # Clock App (GNOME)
    "snapshot" # Camera App (GNOME)
    
    # Multi Media and Documment Viewers
    "gnome-font-viewer" # Font Viewer (GNOME)
    "libreoffice-still" # Office Suite
    "decibels" # Audio Player (GNOME)
    "loupe" # Image Viewer (GNOME)
    "vlc" # Video Player
)

# Install Yay
echo -e "$TAG_STATUS Looking for the \"yay\" package..."

if [[ $(which yay) != "which: no " ]]
then
    echo -e "$TAG_SKIP \"yay\" has been already installed."
else
    echo -e "$TAG_STATUS \"yay\" is not found. Installing \"yay\"..."

    # Build and Install
    pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si
    cd ..
    rm -rf yay-bin

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
    yay -S --needed --sudoloop --answerclean All --answerdiff None $PKG

    echo -e "$TAG_DONE $PKG has been installed."
done
