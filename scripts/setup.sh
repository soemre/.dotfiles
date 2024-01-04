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
nvim -es -c "autocmd User PackerComplete qall" -c "PackerSync"
echo -e "$TAG_DONE Packer Plugins are synchronized."

# Configure Default Shell
echo -e "$TAG_STATUS Configuring the default shell as ${DEFAULT_SHELL}..."

readonly SHELL_PATH=$(which $DEFAULT_SHELL);

if [ $SHELL != $SHELL_PATH ]
then
    if grep -q $SHELL_PATH "/etc/shells"
    then
        echo $SHELL_PATH | sudo tee -a "/etc/shells"
        echo -e "$TAG_DONE Default shell is added to shells."
    else
        echo -e "$TAG_SKIP Default shell is already added to shells." 
    fi

    sudo chsh -s $SHELL_PATH
    echo -e "$TAG_DONE Default shell is configured as ${DEFAULT_SHELL}."
else
    echo -e "$TAG_SKIP Default shell is already configured as ${DEFAULT_SHELL}."
fi
