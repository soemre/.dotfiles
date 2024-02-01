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
    "ttf-jetbrains-mono-nerd"
    "fzf"
    "npm"
    "tmux"
    "less"
    "lua-language-server"
    "go"
    "python"
    "gcc"
    "mandoc"
    "clang"
    "ruff"
    "beautysh"
    "delve"
    "codelldb"
    "python-debugpy"
    "docker"
    "jq"

    # Dependency
    "jack2"
    "ttf-firacode-nerd"
    "google-chrome" # For Flutter

    # OS
    "networkmanager"
    "hyprland" # Tiling Window Manager
    "wl-clipboard"
    "pipewire" # Hardware Server
    "pipewire-pulse" # Audio Server
    "wireplumber"
    "libcamera"
    "pamixer"
    "playerctl"
    "brightnessctl"
    "xbindkeys"
    "bluez"
    "bluez-utils"
    "grim" # Screenshot
    "slurp" # Screen Selection
    "wf-recorder" # Screen Recording
    "swappy" # Simple Photo Editor

    # OS GUI
    "waybar"
    "waypaper-git"
    "swww"
    "ulauncher" # App launcher
    "swaync" # Notification Daemon

    # System Utils
    "neofetch" # System Info
    "btop" # A monitor of resources
    "nautilus" # File Manager (GNOME)
    "gnome-disk-utility" # Disk Util (GNOME)

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

download_packages "${PKGS[@]}"
