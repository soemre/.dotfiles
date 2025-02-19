#!/run/current-system/sw/bin/bash
set -e

home="/home/soemre"

# clone the dotfiles if missing
if [ ! -d "$home/.dotfiles" ]; then
    git clone --recurse-submodules -j8 https://github.com/soemre/.dotfiles.git $home/.dotfiles
fi

# point nixos to the actual configuration files
echo "import $home/.dotfiles/nixos/configuration.nix" > /etc/nixos/configuration.nix
