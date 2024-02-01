#!/bin/bash

declare -a PKGS=(
    "spotify"
    "obs-studio"
    "gimp"
    "discord"
)

download_packages "${PKGS[@]}"
