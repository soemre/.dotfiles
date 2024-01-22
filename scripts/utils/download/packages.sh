#!/bin/bash

download_packages() {
    # Download Packages
    echo -e "$TAG_STATUS Downloading packages..."

    for PKG in "$@"; do
        if yay -Q -q $PKG &> /dev/null
        then
            echo -e "$TAG_SKIP $PKG has been already installed."
            continue
        fi

        echo -e "$TAG_STATUS Downloading $PKG..."

        yes '' | yay -S --needed --sudoloop --answerclean All --answerdiff None $PKG \
            &> $LOG_FILE

        if yay -Q -q $PKG &> /dev/null
        then
            echo -e "$TAG_DONE $PKG has been installed."
        else
            echo -e "$TAG_FAIL Couldn't download ${PKG}."
        fi
    done
}
