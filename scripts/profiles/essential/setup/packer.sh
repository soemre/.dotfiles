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
