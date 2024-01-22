services_enable() {
    echo -e "$TAG_STATUS Enabling system services..."

    for srv in "$@"; do
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
}
