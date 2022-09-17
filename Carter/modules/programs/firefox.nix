{ config, lib, pkgs, ... }:
let
    inherit (builtins) attrNames listToAttrs;
    inherit (lib) mkIf mkMerge mkOption mkEnableOption mkPackageOption types;

    cfg = config.zyls.programs.firefox;
    cfgPlasma = config.services.xserver.desktopManager.plasma5;
in
{
    options = {
        zyls.programs.firefox = {
            enable = mkEnableOption "firefox";

            package = mkPackageOption pkgs "firefox-wayland" { };

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
                    name = "firefox";
                    package = cfg.package;
                }
            ))
        ];

        nixpkgs.config.firefox.enablePlasmaBrowserIntegration = cfgPlasma.enable;
    };

#     config = mkIf cfg.enable (mkMerge [
#         ({
#             users.users = listToAttrs (map
#                 (user: {
#                     name = user;
#                     value = {
#                         packages = [ cfg.package ] // (mkIf cfg.autoStart (
#                             pkgs.makeAutostartItem {
#                                 name = "firefox";
#                                 package = cfg.package;
#                             }
#                         ));
#                     };
#                 })
#                 cfg.users
#             );
#         })
#         (mkIf cfgPlasma.enable {
#             nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;
#         })
#     ]);
}
