echo -e "$TAG_STATUS Setting up TPM..."

if [ -d "${HOME}/.tmux/plugins/tpm" ]; then
    echo -e "$TAG_SKIP TPM is already set."
else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &> $LOG_FILE

    echo -e "$TAG_DONE TPM has been set."
fi
