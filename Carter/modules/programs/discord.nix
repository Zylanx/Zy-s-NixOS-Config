{ config, lib, pkgs, ... }:
let
    inherit (builtins) attrNames attrValues listToAttrs;
    inherit (lib) mkIf mkOption mkEnableOption mkPackageOption types traceVal;

    cfg = config.zyls.programs.discord;
in
{
    options = {
        zyls.programs.discord = {
            enable = mkEnableOption "discord";

            package = mkPackageOption pkgs "discord" { };

            autoStart = mkOption {
                type = types.bool;

                default = false;
            };
        };
    };

    config = mkIf cfg.enable {
#         nixpkgs.config.packageOverrides = opkgs: {
#             discord = opkgs."${cfg.package.pname}".override {
#             nss = opkgs.nss_latest;
#             };
#         };
#
#         nixpkgs.overlays = [
#             (final: prev: {
#                 "${cfg.package.pname}" =
#             })
#         ]

        environment.systemPackages = let
            package-override = cfg.package.override { nss = pkgs.nss_latest; };
        in
        [
            package-override
            (mkIf cfg.autoStart (
                pkgs.makeAutostartItem {
                    name = "discord";
                    package = package-override;
                }
            ))
        ];
    };
}
