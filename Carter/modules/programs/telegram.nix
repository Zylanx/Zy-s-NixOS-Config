{ config, pkgs, ... }:
let
    cfg = config.zyls.programs.telegram;

    users = builtins.attrNames config.users.users;
in
{
    options = {
        zyls.programs.discord = {
            enable = mkEnableOption "telegram";

            package = mkPackageOption pkgs tdesktop;

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

    config = mkIf cfg.enable {
        users.users = listToAttrs (map
            (user: {
                name = user;
                value = {
                    packages = [ cfg.package ] // (mkIf cfg.autoStart (
                        makeAutostartItem {
                            name = "telegram-desktop";
                            package = cfg.package;
                        }
                    ));
                };
            })
            cfg.users
        );
    };
}
