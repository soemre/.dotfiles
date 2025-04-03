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
      extraGroups = ["networkmanager" "wheel" "adbusers" "plugdev"];
      packages = with pkgs; [];
    };
  };

  virtualisation = {
    libvirtd = {
      enable = true;
    };
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };

  programs = {
    hyprland.enable = true;

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
      wl-clipboard
      postman
      pixelorama
      libreoffice
      discord
      figma-linux
      gimp
      telegram-desktop
      swww # WP Client
      waypaper # WP GUI
      nwg-panel # Status Bar (Temp)
      findex # App Launcher
      overskride # Bluetooth Frontend
      nautilus # Dora the Explorer

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
      caligula # Disk Imaging
      bunyan-rs
      jq
      toml-cli

      # CLI - Cargo Extensions
      sqlx-cli
      cargo-udeps
      cargo-expand
      cargo-binutils
      probe-rs-tools

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

  fonts.packages = with pkgs; [
    nerdfonts
  ];

  system.stateVersion = "24.11";
}
