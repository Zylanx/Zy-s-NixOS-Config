{ config, pkgs, mkEnableOption, mkOption, mkIf, mkMerge, ... }:
let
    cfg = config.zyls.desktops.plasma;
in
{
    options = {
        zyls.desktops.plasma = {
            enable = mkEnableOption "plasma";
        };
    };

    config = mkIf cfg.enable {
            # Enable the X11 windowing system.
            services.xserver.enable = true;

            # Enable the Plasma 5 Desktop Environment.
            services.xserver.displayManager.sddm.enable = true;
            services.xserver.desktopManager.plasma5.enable = true;

            services.xserver.displayManager.defaultSession = "plasmawayland";
    };
}
