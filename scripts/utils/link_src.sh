#!/bin/bash

link_src() {
    # Adds symbolic links to given directories
    echo -e "$TAG_STATUS Linking the config files..."

    local -n links="$1"

    for from in "${!links[@]}"; do
        to="${links["$from"]}/$from";

        # Skip existing paths
        if [ -L $to ]; then
            echo -e "$TAG_SKIP $from is already linked to $to";
            continue;
        fi

        ln -s "$ABSOLUTE_PATH/src/$from" "$to";
        echo -e "$TAG_DONE Linked $to to $from";
    done
}
