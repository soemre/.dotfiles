#!/bin/bash

declare -a setups=(
    "packer.sh"
    "shell.sh"
    "wallpaper.sh"
    "services.sh"
    "flutter.sh"
    "nvidia.sh"
    "tpm.sh"
)

relative_source "${PATH_TO_SCRIPTS}/profiles/essential/setup" "${setups[@]}"
