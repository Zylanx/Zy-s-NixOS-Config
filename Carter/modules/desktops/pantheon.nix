{ config, lib, pkgs, ... }:
let
    inherit (lib) mkIf mkEnableOption mkMerge;

    cfg = config.zyls.desktops.pantheon;
    cfgAutoLogin = config.services.xserver.displayManager.autoLogin;
in
{
    options = {
        zyls.desktops.pantheon = {
            enable = mkEnableOption "pantheon";
        };
    };

    config = mkIf cfg.enable {
        services = {
            pantheon = {
                contractor.enable = true;
                apps.enable = true;
            };
            
            xserver = {
                displayManager.lightdm.enable = true;

                desktopManager.pantheon = {
                    enable = true;
                };
            };
        };
    };
}
