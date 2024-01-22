#!/bin/bash

# Initialize Bootstrap
source "$(dirname $0)/scripts/config.sh"; # Must sourced manually
source "$(dirname $0)/scripts/utils.sh"; # Must sourced manually
source "$(dirname $0)/scripts/init.sh";

# Start Bootstrap
echo -e "$TAG_STATUS Need sudo access to run."
sudo -v # Get sudo access

# Run Bootstrap
source "$(dirname $0)/scripts/profiles.sh";

# End Bootstrap
echo -e "$TAG_DONE Bootstrap has been finished successfully. Reboot to see the changes."
sudo -k
