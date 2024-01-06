#!/bin/bash

create_log_file() {
    local log_dir="${ABSOLUTE_PATH}/logs"
    local file_name="${log_dir}/$(log_file_name).log"

    if ! [ -d "$log_dir" ]
    then
        mkdir "$log_dir"
    fi

    if [ -f "$file_name" ]
    then
        return -1
    fi
    
    touch $file_name
    echo "$file_name"
    return 0
}
