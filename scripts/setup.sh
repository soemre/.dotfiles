#!/bin/bash

# Install Packer (NeoVim Plugin Manager)
echo -e "$TAG_STATUS Installing Packer..."

readonly PACKER_PATH="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

if ! [ -d $PACKER_PATH ]
then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim $PACKER_PATH \
        &> $LOG_FILE

    echo -e "$TAG_DONE Packer has been installed."
else
    echo -e "$TAG_SKIP Packer is already installed."
fi

# Sync Packer Plugins
echo -e "$TAG_STATUS Synchronizing Packer Plugins..."
nvim -c "autocmd User PackerComplete qall" -c "PackerSync" > /dev/null 2> $LOG_FILE
echo -e "$TAG_DONE Packer Plugins are synchronized."

# Configure Default Shell
echo -e "$TAG_STATUS Configuring the default shell as ${DEFAULT_SHELL}..."

readonly SHELL_PATH=$(PATH=/bin which $DEFAULT_SHELL);

if [ $SHELL != $SHELL_PATH ]
then
    if grep -q ^$SHELL_PATH "/etc/shells"
    then
        echo -e "$TAG_SKIP Default shell is already added to shells."
    else
        echo $SHELL_PATH | sudo tee -a "/etc/shells" &> /dev/null
        echo -e "$TAG_DONE Default shell is added to shells."
    fi

    sudo chsh -s $SHELL_PATH &> $LOG_FILE
    sudo chsh -s $SHELL_PATH $USER &> $LOG_FILE
    echo -e "$TAG_DONE Default shell is configured as ${DEFAULT_SHELL}."
else
    echo -e "$TAG_SKIP Default shell is already configured as ${DEFAULT_SHELL}."
fi

# Link Wallpaper
readonly wallpapers_dir="${HOME}/wallpapers"

echo -e "$TAG_STATUS Seting up the default wallpaper..."

if ! [ -d "$wallpapers_dir" ]
then
    mkdir "$wallpapers_dir"

    echo -e "$TAG_DONE Created: $wallpapers_dir"
fi

if [ -L "${wallpapers_dir}/default_wallpaper.jpg" ]
then
    echo -e "$TAG_SKIP The default wallpaper is already linked."
else
    ln -s "$ABSOLUTE_PATH/misc/default_wallpaper.jpg" "$wallpapers_dir"
    echo -e "$TAG_DONE The default wallpaper has been linked."
fi

# Enable Services
declare -a services=(
    "bluetooth.service"
)

echo -e "$TAG_STATUS Enabling system services..."

for srv in "${services[@]}"; do
    if systemctl is-enabled "$srv" &> $LOG_FILE; then
        echo -e "$TAG_SKIP $srv is already enabled."
        continue
    fi

    echo -e "$TAG_STATUS Enabling $srv service..."

    sudo systemctl enable "$srv" &> $LOG_FILE

    if ! systemctl is-enabled "$srv" &> $LOG_FILE; then
        echo -e "$TAG_FAIL Couldn't enable \"$srv\" service."
        continue
    fi

    echo -e "$TAG_DONE $srv service has been enabled."
done

# Setup Symbolic Link Of Google Chrome For Flutter
echo -e "$TAG_STATUS Linking chrome..."

if ! [ -L $CHROME_EXECUTABLE ]; then
    ln -s /bin/google-chrome-stable /bin/google-chrome &> $LOG_FILE
    echo -e "$TAG_DONE Chrome has been linked."
else
    echo -e "$TAG_SKIP Chrome is already linked."
fi

# Nvidia Setup
source "${PATH_TO_SCRIPTS}/setup/nvidia.sh"
