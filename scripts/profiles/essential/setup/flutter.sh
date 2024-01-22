# Setup Symbolic Link Of Google Chrome For Flutter
echo -e "$TAG_STATUS Linking chrome..."

if ! [ -L $CHROME_EXECUTABLE ]; then
    ln -s /bin/google-chrome-stable /bin/google-chrome &> $LOG_FILE
    echo -e "$TAG_DONE Chrome has been linked."
else
    echo -e "$TAG_SKIP Chrome is already linked."
fi
