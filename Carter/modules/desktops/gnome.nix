{ config, pkgs, mkEnableOption, mkOption, mkIf, mkMerge, ... }:
let
    cfg = config.zyls.desktops.gnome;
    cfgAutoLogin = services.xserver.displayManager.autoLogin;
in
{
    options = {
        zyls.desktops.gnome = {
            enable = mkEnableOption "gnome";
        };
    };

    config = mkIf cfg.enable (mkMerge [
        {
            # Enable the X11 windowing system.
            services.xserver.enable = true;

            # Enable the GNOME Desktop Environment.
            services.xserver.displayManager.gdm.enable = true;
            services.xserver.desktopManager.gnome.enable = true;

        }
        (mkIf cfgAutoLogin.enable {
            # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
            systemd.services = {
                "getty@tty1".enable = false;
                "autovt@tty1".enable = false;
            };
        })
    ]);
}
