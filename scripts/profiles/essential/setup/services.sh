# Enable Services
declare -a services=(
    "bluetooth.service"
    "docker.socket"
)

services_enable "${services[@]}"
