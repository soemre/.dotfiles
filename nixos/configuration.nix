# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
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

  console.keyMap = "uk";

  users = {
    defaultUserShell = pkgs.nushell;

    users.soemre = {
      isNormalUser = true;
      description = "Emre";
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [];
    };
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      openssl
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    sessionVariables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    };

    systemPackages = with pkgs; [
      # Env
      ghostty
      gnome-boxes
      syncthing
      firefox
      gnomeExtensions.stopwatch
      wl-clipboard

      # CLI
      git
      fzf
      fastfetch
      tree-sitter
      neovim
      tmux
      btop
      yazi
      docker
      nushell
      starship
      zoxide
      ripgrep
      weechat
      ollama-cuda
      usbutils
      sqlx-cli
      cargo-udeps
      cargo-expand

      # Bcs I have to
      gnumake # nvim telescope-fzf dependency
      nodejs # no escape from JS
      zip
      unzip
      pkg-config

      # Langs
      python3Full
      rustup
      gcc

      # ORG
      doctl
      gh

      # Personal
      obsidian
      spotify
    ];
  };

  system.stateVersion = "24.11";
}
