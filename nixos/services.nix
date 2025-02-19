{ ... }: {
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
        };

        ollama = {
            enable = true;
            acceleration = "cuda";
            loadModels = [
                deepseek-r1:8b
                llava:7b
            ];
        };
    };
}
