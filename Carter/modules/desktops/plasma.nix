{ config, lib, pkgs, ... }:
let
    inherit (lib) mkIf mkEnableOption;

    cfg = config.zyls.desktops.plasma;
in
{
    options = {
        zyls.desktops.plasma = {
            enable = mkEnableOption "plasma";
        };
    };

    config = mkIf cfg.enable {
            nixpkgs.overlays = [
                (final: prev: { adwaita-icon-theme-without-gnome = prev.gnome.adwaita-icon-theme.overrideAttrs (oldAttrs: { passthru = null; }); })
                (final: prev: { adwaita-icon-theme-without-gnome = prev.gnome.adwaita-icon-theme.override      { gnome = null; gtk3 = null; }; })
            ];

            # Enable the X11 windowing system.
            services.xserver.enable = true;

            # Enable the Plasma 5 Desktop Environment.
            services.xserver.displayManager.sddm.enable = true;
            services.xserver.desktopManager.plasma5.enable = true;

            services.xserver.displayManager.defaultSession = "plasmawayland";

            environment.systemPackages = [
                pkgs.adwaita-icon-theme-without-gnome
            ];
    };
}
