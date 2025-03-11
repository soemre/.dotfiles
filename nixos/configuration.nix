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
      extraGroups = ["networkmanager" "wheel" "adbusers"];
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

  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        openssl
      ];
    };

    adb.enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  environment = let
    androidComposition = pkgs.androidenv.composeAndroidPackages {
      platformVersions = ["34" "35"];
      buildToolsVersions = ["33.0.1"];
      includeEmulator = true;
      includeSystemImages = true;
      systemImageTypes = ["google_apis"];
      abiVersions = ["x86_64"];
    };
    androidSdk = androidComposition.androidsdk;
  in {
    sessionVariables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
      ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
    };

    systemPackages = with pkgs; [
      # Env
      ghostty
      gnome-boxes
      syncthing
      brave # Firefox </3
      gnomeExtensions.stopwatch
      wl-clipboard
      postman
      pixelorama

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
      caligula # Disk Imaging
      bunyan-rs

      # Bcs I have to
      gnumake # nvim telescope-fzf dependency
      nodejs # no escape from JS
      zip
      unzip
      pkg-config
      androidSdk
      jdk # Yeahh :/
      steam-run # Lil Magic

      # Langs & Frameworks
      python3Full
      rustup
      gcc
      flutter

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
