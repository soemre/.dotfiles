#!/bin/bash

# Define Config
CONFIG="$HOME/.display_mode"

change_current_monitor() {
    local will_change=1
    local new_display

    for dp in "$@"; do
        if [ "$will_change" == 0 ] || (! echo "${MONITORS[@]}" | grep -q "$DISPLAY_MODE_CURRENT") || [ "$DISPLAY_MODE_CURRENT" == "" ]; then
            new_display="$dp"
            will_change=1
            break
        fi

        if [ "$dp" == "$DISPLAY_MODE_CURRENT" ]; then
            will_change=0
        fi
    done

    if [ "$will_change" != 1 ]; then
        new_display="$1"
    fi

    echo -e "$(jq ". | .display.mode.single.current = \"$new_display\"" "$CONFIG")" > $CONFIG # Change Config
    DISPLAY_MODE_CURRENT="$new_display"
}

if [ "$DISPLAY_MODE" == "SINGLE" ]; then
    # Reload the config to reset previous changes
    hyprctl reload

    # Get the list of monitors
    declare -a MONITORS=($(hyprctl monitors -j | jq -r '.[].name'))

    # Create Config
    if ! [ -f "$CONFIG" ]; then
        touch "$CONFIG"
        echo {} > $CONFIG
    fi

    DISPLAY_MODE_CURRENT="$(jq -r '. | .display.mode.single.current' $CONFIG )" # Read Config

    if (! echo "${MONITORS[@]}" | grep -q "$DISPLAY_MODE_CURRENT") || [ "$DISPLAY_MODE_CURRENT" == "" ] || [ "$1" == "change" ]; then
        change_current_monitor "${MONITORS[@]}"
    fi

    # Disable the monitors that are not the current monitor
    for dp in "${MONITORS[@]}"; do
        if [ "$dp" != "$DISPLAY_MODE_CURRENT" ]; then
            hyprctl keyword monitor "${dp}",disable
        fi
    done
fi
