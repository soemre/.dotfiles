relative_source() {
    local files=("$@")

    for file in "${files[@]:1}"; do
        source "$files/$file";
    done
}
