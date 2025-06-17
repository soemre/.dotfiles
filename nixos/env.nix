{
  pkgs,
  config,
  lib,
  ...
}: let
  pkgs-unstable = import <unstable> {
    config = config.nixpkgs.config;
  };
  libs = with pkgs; [
    openssl.dev
  ];
in {
  programs = {
    hyprland.enable = true;
    fish.enable = true;
    adb.enable = true;

    nix-ld = {
      enable = true;
      libraries = with pkgs;
        [
          llvmPackages.libclang
        ]
        ++ libs;
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment = let
    androidComposition = pkgs.androidenv.composeAndroidPackages {
      platformVersions = ["33" "34" "35"];
      buildToolsVersions = ["33.0.1" "34.0.0"];
      includeEmulator = true;
      # includeNDK = true;
      includeSystemImages = true;
      systemImageTypes = ["google_apis"];
      abiVersions = ["x86_64"];
      extraLicenses = [
        "android-googletv-license"
        "android-sdk-arm-dbt-license"
        "android-sdk-license"
        "android-sdk-preview-license"
        "google-gdk-license"
        "intel-android-extra-license"
        "intel-android-sysimage-license"
        "mips-android-sysimage-license"
      ];
    };
    androidSdk = androidComposition.androidsdk;
    packages-unstable = with pkgs-unstable; [
      dioxus-cli
      kicad
      vscode
      wasm-bindgen-cli
      tailwindcss_4
      stm32cubemx
      qgroundcontrol
      ollama-cuda
    ];
    packages = with pkgs; [
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
      obs-studio
      steam-run # Lil Magic
      obsidian
      spotify
      vlc
      ardour
      cheese # Webcam
      # davinci-resolve

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
      starship
      zoxide
      ripgrep
      weechat
      usbutils
      caligula # Disk Imaging
      bunyan-rs
      jq
      toml-cli
      openocd
      zip
      unzip
      minicom

      # CLI - Cargo Extensions
      sqlx-cli
      cargo-udeps
      cargo-expand
      cargo-binutils
      cargo-generate
      probe-rs-tools
      wasm-pack # Not exactly a cargo extension but related to cargo

      # Tool Specific
      python3Full
      rustup
      clang
      gcc
      gcc-arm-embedded
      flutter327
      nodejs # no escape from JS
      gnumake # nvim telescope-fzf dependency + yeahhhhhhhhh... "no cargo" sucks
      cmake # it's also a dependency of dioxus
      androidSdk
      jdk17 # Yeahh :/
      bear # C <3 emanuele
      pkg-config
      doctl
      gh
    ];
  in {
    sessionVariables = {
      PKG_CONFIG_PATH = lib.makeSearchPath "lib/pkgconfig" libs;
      ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
      ANDROID_HOME = "$ANDROID_SDK_ROOT";
      # ANDROID_NDK_HOME = "$ANDROID_HOME/ndk-bundle";
      JAVA_HOME = "${pkgs.jdk17}";
      LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
    };

    systemPackages = packages ++ packages-unstable ++ libs;
  };
}
