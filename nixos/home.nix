{
  config,
  pkgs,
  ...
}: let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
in {
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager = {
    useGlobalPkgs = true;

    users.soemre = {
      config,
      lib,
      ...
    }: {
      home.stateVersion = "24.11";

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
        ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${dotsdir}/.tmux.conf";
        ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${dotsdir}/.gitconfig";
      };
    };
  };
}
