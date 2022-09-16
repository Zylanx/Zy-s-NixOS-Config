{ config, pkgs, ... }:
let
    cfg = config.zyls.programs.discord;

    users = builtins.attrNames config.users.users;
in
{
    options = {
        zyls.programs.discord = {
            enable = mkEnableOption "discord";

            package = mkPackageOption pkgs discord;

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
        nixpkgs.config.packageOverrides = pkgs: {
            discord = pkgs."${cfg.package.pname}".override {
            nss = pkgs.nss_latest;
            };
        };

        users.users = listToAttrs (map
            (user: {
                name = user;
                value = {
                    packages = [ cfg.package ] // (mkIf cfg.autoStart (
                        makeAutostartItem {
                            name = "discord";
                            package = cfg.package;
                        }
                    ));
                };
            })
            cfg.users
        );
    };
}
