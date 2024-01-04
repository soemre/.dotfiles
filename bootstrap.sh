# Add the config file first
source "$(dirname $0)/scripts/config.sh";

declare -a SCRIPTS=(
    "utils.sh"
    "init.sh"
    "install.sh"
    "symlink.sh"
    "setup.sh"
)

echo -e "$TAG_STATUS Need sudo access to run."

# Get sudo access
sudo -v 

for exec in "${SCRIPTS[@]}"; do
    source "${PATH_TO_SCRIPTS}/${exec}";
done

echo -e "$TAG_DONE Bootstrap has been finished successfully."

sudo -k
