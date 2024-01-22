source_profiles() {
    local -a scripts=(
        "init.sh"
        "install.sh"
        "misc.sh"
        "symlink.sh"
        "setup.sh"
    )

    for profile in "$@"; do
        local path="${PATH_TO_SCRIPTS}/profiles/$profile"

        # Check whether scripts exist in profile, and after that source them.
        for script in "${scripts[@]}"; do
            if [ -f "$path/$script" ]; then
                relative_source "$path" "$script"
            fi
        done
    done
}
