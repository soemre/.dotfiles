{pkgs, ...}: {
  programs = {
    hyprland.enable = true;

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # openssl
      ];
    };

    adb.enable = true;
  };

  fonts.packages = with pkgs; [
    nerdfonts
  ];

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
      # PKG_CONFIG_PATH = "$PKG_CONFIG_PATH:${pkgs.lib.strings.makeLibraryPath [
      #   pkgs.openssl
      # ]}";
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
      obs-studio
      steam-run # Lil Magic
      obsidian
      spotify

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
      openocd
      zip
      unzip

      # CLI - Cargo Extensions
      sqlx-cli
      cargo-udeps
      cargo-expand
      cargo-binutils
      probe-rs-tools

      # Tool Specific
      python3Full
      rustup
      gcc
      gcc-arm-embedded
      flutter
      nodejs # no escape from JS
      gnumake # nvim telescope-fzf dependency + yeahhhhhhhhh... "no cargo" sucks
      androidSdk
      jdk # Yeahh :/
      # Idk
      llvmPackages_latest.lldb
      llvmPackages_latest.libllvm
      llvmPackages_latest.libcxx
      llvmPackages_latest.clang
      bear # C <3 emanuele
      pkg-config
      doctl
      gh
      stm32cubemx
    ];
  };
}
