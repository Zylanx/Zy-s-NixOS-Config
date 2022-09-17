{ config, lib, pkgs, ... }:
let
    inherit (builtins) attrNames listToAttrs;
    inherit (lib) mkIf mkOption mkEnableOption mkPackageOption types;

    cfg = config.zyls.programs.telegram;
in
{
    options = {
        zyls.programs.telegram = {
            enable = mkEnableOption "telegram";

            package = mkPackageOption pkgs "tdesktop" { };

            autoStart = mkOption {
                type = types.bool;

                default = false;
            };
        };
    };

    config = mkIf cfg.enable {
        environment.systemPackages = [
            cfg.package
            (mkIf cfg.autoStart (
                pkgs.makeAutostartItem {
                    name = "telegramdesktop";
                    package = cfg.package;
                }
            ))
        ];
    };
}
