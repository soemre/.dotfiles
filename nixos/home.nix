{
  config,
  pkgs,
  ...
}: let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
in {
  imports = [
    (import "${home-manager}/nixos")
  ];

  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  home-manager = {
    useGlobalPkgs = true;

    users.soemre = {
      config,
      lib,
      ...
    }: {
      home.stateVersion = "25.05";

      home.activation = {
        cloneDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
          if [ ! -d "$HOME/.dotfiles/.git" ]; then
            ${pkgs.git}/bin/git clone --recurse-submodules -j8 https://github.com/soemre/.dotfiles.git $HOME/.dotfiles
          fi
        '';
      };

      home.file = let
        dotsdir = "${config.home.homeDirectory}/.dotfiles";
      in {
        ".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink "${dotsdir}/ghostty";
        ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotsdir}/nvim";
        ".config/nushell".source = config.lib.file.mkOutOfStoreSymlink "${dotsdir}/nushell";
        ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${dotsdir}/hypr";
        ".config/waypaper".source = config.lib.file.mkOutOfStoreSymlink "${dotsdir}/waypaper";
        ".config/fish".source = config.lib.file.mkOutOfStoreSymlink "${dotsdir}/fish";
        ".config/atuin".source = config.lib.file.mkOutOfStoreSymlink "${dotsdir}/atuin";
        ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${dotsdir}/.tmux.conf";
        ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${dotsdir}/.gitconfig";
      };

      services = {
          kdeconnect = {
              enable = true;
          };

          mako.enable = true;
      };
    };
  };
}
