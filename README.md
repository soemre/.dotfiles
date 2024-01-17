## About
This repository includes my dotfile configurations with initialization scripts
to set up my preferred desktop environment on top of a minimal Arch Linux profile.

### About Scripts
Bootstrap scripts have many pre-configured installations via `yay`. These
installations include the tools I use, such as `Flutter`, `Go`, `Rust`, or
personal tools like `Spotify`, etc. If you don't want to install some of them,
feel free to exclude them from installation script before running the
`bootstrap.sh`. Note that this can only be done by cloning the repository
first and making your changes afterward; you can't use the remote installation
script.

## Installation
Installation is fully automated. Just run the remote script to perform everything
automaticlly, including getting the repository, or install this repository and
run the `bootstrap.sh` script to start setting up your desktop environment.

### Remote Bootstrap
```bash
$ curl -s https://raw.githubusercontent.com/emresoysuren/.dotfiles/main/bootstrap_remote.sh | bash
```

## Included Configs:
- NeoVim
- Alacritty
- Git
- Fish
- Hyprland
- Waybar
- Waypaper
- Tmux
- Xbindkeys
