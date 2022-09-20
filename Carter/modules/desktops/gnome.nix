 { config, lib, pkgs, ... }:
let
    inherit (lib) mkIf mkEnableOption mkMerge;

    cfg = config.zyls.desktops.gnome;
    cfgAutoLogin = config.services.xserver.displayManager.autoLogin;
in
{
    options = {
        zyls.desktops.gnome = {
            enable = mkEnableOption "gnome";
        };
    };

    config = mkIf cfg.enable (
        mkMerge [
            {
                # Enable the X11 windowing system.
                services.xserver.enable = true;

                # Enable the GNOME Desktop Environment.
                services.xserver.displayManager.gdm.enable = true;
                services.xserver.desktopManager.gnome.enable = true;

                environment.systemPackages = with pkgs; [
                    gnomeExtensions.appindicator
                    gnomeExtensions.dash-to-dock
                    gnomeExtensions.dash-to-panel
                    gnome.gnome-tweaks
                ];

                services.udev.packages = with pkgs; [
                    gnome.gnome-settings-daemon
                ];
            }
            {
                environment.gnome.excludePackages = (with pkgs; [
                    gnome-tour
                ]) ++ (with pkgs.gnome; [
                    cheese
                    gnome-music
                ]);
            }
            {
                # Config for GSConnect
                programs.kdeconnect = {
                     enable = true;
                     package = pkgs.gnomeExtensions.gsconnect;
                 };
            }
            (mkIf cfgAutoLogin.enable {
                # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
                systemd.services = {
                    "getty@tty1".enable = false;
                    "autovt@tty1".enable = false;
                };
            })
        ]
    );
}
