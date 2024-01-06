#!/bin/bash

declare -a PKGS=(
    # Development
    "git"
    "github-cli"
    "rust"
    "neovim"
    "fish"
    "alacritty-git"
    "flutter"
    "android-studio"
    "ttf-firacode-nerd"
    "fzf"
    "npm"
    "tmux"

    # Dependency
    "jack2"

    # Personal
    "google-chrome"
    "spotify"
    "obs-studio"

    # OS
    "networkmanager"
    "hyprland" # Tiling Window Manager
    "wl-clipboard"
    "pipewire" # Hardware Server 
    "pulseaudio" # Audio Server
    "wireplumber" 
    "libcamera"
    "pamixer"
    "playerctl"
    "brightnessctl"
    "xbindkeys"

    # OS GUI
    "waybar"
    "waypaper-git" 
    "swww"
    "ulauncher" # App launcher

    # System Utils
    "neofetch" # System Info
    "btop" # A monitor of resources
    "nautilus" # File Manager (GNOME)
    "gnome-disk-utility" # Disk Util (GNOME)

    # Drivers
    "nvidia" # Nvidia driver
    "nvidia-settings"

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

if which yay &> $LOG_FILE
then
    echo -e "$TAG_SKIP \"yay\" has been already installed."
else
    echo -e "$TAG_STATUS \"yay\" is not found. Installing \"yay\"..."

    # Build and Install
    yes | sudo pacman -S --needed git base-devel &> $LOG_FILE
    git clone https://aur.archlinux.org/yay-bin.git &> $LOG_FILE
    cd yay-bin
    yes | makepkg -si &> $LOG_FILE
    cd ..
    rm -rf yay-bin > /dev/null

    # Check whether the installation is successful
    if which yay &> $LOG_FILE
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
yes | yay -Syu --sudoloop --answerclean All --answerdiff None &> $LOG_FILE
echo -e "$TAG_DONE Packages have been updated."

# Download Packages
echo -e "$TAG_STATUS Downloading packages..."

for PKG in "${PKGS[@]}"; do
    if yay -Q -q $PKG &> /dev/null
    then
        echo -e "$TAG_SKIP $PKG has been already installed."
        continue
    fi

    echo -e "$TAG_STATUS Downloading $PKG..."

    yes | yay -S --needed --sudoloop --answerclean All --answerdiff None $PKG \
        &> $LOG_FILE

    if yay -Q -q $PKG &> /dev/null
    then
        echo -e "$TAG_DONE $PKG has been installed."
    else
        echo -e "$TAG_FAIL Couldn't download ${PKG}."
    fi
done
