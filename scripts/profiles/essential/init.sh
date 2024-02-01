#!/bin/bash

# Installing Yay
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
yes '' | yay -Syu --sudoloop --answerclean All --answerdiff None &> $LOG_FILE
echo -e "$TAG_DONE Packages have been updated."
