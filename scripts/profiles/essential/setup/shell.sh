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
