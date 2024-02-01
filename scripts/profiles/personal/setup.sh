#!/bin/bash

declare -a setups=(
    "wallpaper.sh"
)

relative_source "${PATH_TO_SCRIPTS}/profiles/personal/setup" "${setups[@]}"
