{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager = {
    useGlobalPkgs = true;

    users.soemre = {config, lib, ...}: {
      home.stateVersion = "24.11";

      home.activation.cloneDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
        if [ ! -d "$HOME/.dotfiles/.git" ]; then
          ${pkgs.git}/bin/git clone --recurse-submodules -j8 https://github.com/soemre/.dotfiles.git $HOME/.dotfiles
        fi
      '';

      home.file = {
        ".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/ghostty";
        ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nvim";
        ".config/nushell".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nushell";
        ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.tmux.conf";
        ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.gitconfig";
      };

      dconf.settings =
      let
        custom-keybindings = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings";
      in
      {
        "org/gnome/desktop/interface" = {
	      color-scheme = "prefer-dark";
	      clock-show-date = false;
	      show-battery-percentage = true;
	    };
        "org/gnome/desktop/wm/keybindings" = {
	      close = ["<Super>q"];
	      toggle-maximized = ["<Super>f"];
	    };
	    "org/gnome/shell" = {
          disable-user-extensions = false;
	      enabled-extensions = with pkgs.gnomeExtensions; [
              stopwatch.extensionUuid
              maximized-by-default-reborn.extensionUuid
          ];
	    };
        "${custom-keybindings}/custom0" = {
          binding = "<Super>Return";
          command = "ghostty";
          name = "Term";
        };
      };
    };
  };
}
