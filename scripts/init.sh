# Initialize Log File
readonly LOG_FILE="$(create_log_file)"

if [ LOG_FILE ]
then
    echo -e "$TAG_DONE Created and loging to: $LOG_FILE"
else
    echo -e "$TAG_FAIL Tried to create a log file, but it already exists."
fi
