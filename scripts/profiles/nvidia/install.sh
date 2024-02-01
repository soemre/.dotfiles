#!/bin/bash

declare -a PKGS=(
    "nvidia" # Nvidia driver
    "nvidia-settings"
)

download_packages "${PKGS[@]}"
