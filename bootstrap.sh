readonly PATH_TO_SCRIPTS="$(dirname $0)/scripts"

declare -a SCRIPTS=(
    "install.sh"
    "symlink.sh"
)

for exec in "${SCRIPTS[@]}"; do

    source "${PATH_TO_SCRIPTS}/${exec}";

done
