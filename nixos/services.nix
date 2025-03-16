{pkgs, ...}: {
  services = {
    syncthing = {
      enable = true;
      group = "users";
      user = "soemre";
      dataDir = "/home/soemre/sync";
      configDir = "/home/soemre/.config/syncthing";
    };

    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      xkb = {
        layout = "gb";
        variant = "";
      };
    };

    ollama = {
      enable = true;
      acceleration = "cuda";
      loadModels = [
        deepseek-r1:8b
        llava:7b
      ];
    };

    udev.packages = [
      (pkgs.writeTextFile {
        name = "69-probe-rs";
        text = builtins.readFile ./etc/69-probe-rs.rules;
        destination = "/etc/udev/rules.d/69-probe-rs.rules";
      })
    ];
  };
}
