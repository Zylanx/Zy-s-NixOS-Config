{ pkgs, ... }:
{
    nixpkgs.config.packageOverrides = pkgs: {
        kicad = pkgs.kicad.overrideAttrs (previousAttrs: {
            base = previousAttrs.base.overrideAttrs (previousAttrs: {
                cmakeFlags = previousAttrs.cmakeFlags ++ [ "-DKICAD_USE_EGL=ON" ];
            });
        });
    };
}
