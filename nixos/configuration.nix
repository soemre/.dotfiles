# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./home.nix
      ./services.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "NULL";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  users.defaultUserShell = pkgs.nushell;

  users.users.soemre = {
    isNormalUser = true;
    description = "Emre";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Env
    pkgs.ghostty
    pkgs.gnome-boxes
    pkgs.syncthing
    pkgs.firefox
    pkgs.gnomeExtensions.stopwatch
    pkgs.gnomeExtensions.maximized-by-default-reborn
    pkgs.wl-clipboard
    
    # CLI
    pkgs.git
    pkgs.gh
    pkgs.fzf
    pkgs.fastfetch
    pkgs.tree-sitter
    pkgs.neovim
    pkgs.tmux
    pkgs.btop
    pkgs.yazi
    pkgs.docker
    pkgs.nushell
    pkgs.starship
    pkgs.zoxide
    pkgs.ripgrep
    pkgs.weechat
    pkgs.ollama-cuda
    pkgs.gnumake # nvim telescope-fzf dependency

    # Langs
    pkgs.python3Full
    pkgs.rustup
    pkgs.gcc

    # Personal
    pkgs.obsidian
    pkgs.spotify
  ];

  system.stateVersion = "24.11";
}
