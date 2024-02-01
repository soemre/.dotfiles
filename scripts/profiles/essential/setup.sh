#!/bin/bash

declare -a setups=(
    "packer.sh"
    "shell.sh"
    "services.sh"
    "flutter.sh"
    "tpm.sh"
)

relative_source "${PATH_TO_SCRIPTS}/profiles/essential/setup" "${setups[@]}"
