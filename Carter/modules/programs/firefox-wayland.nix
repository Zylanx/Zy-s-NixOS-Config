{ config, pkgs, types, mkOption, mkIf, makeAutostartItem. ... }:
let
    cfg = config.zyls.programs.firefox;
    cfgPlasma = config.services.xserver.desktopManager.plasma5;

    users = builtins.attrNames config.users.users;
in
{
    options = {
        zyls.programs.firefox = {
            package = mkPackageOption pkgs firefox-wayland;

            autoStart = mkOption {
                type = types.bool;

                default = false;
            };

            users = mkOption {
                type = types.listOf (types.enum users)  # TODO: Add duplicate check

                default = [];
            };
        };
    };

    config = {
        users.users = listToAttrs (map
            (user: {
                name = user;
                value = {
                    packages = [ cfg.package ] // (mkIf cfg.autoStart (
                        makeAutostartItem {
                            name = "firefox";
                            package = cfg.package;
                        }
                    ));
                };
            })
            cfg.users
        );

        nixpkgs.config.firefox.enablePlasmaBrowserIntegration = mkIf config.services.xserver.desktopManager.plasma5.enable true;
    };
}
