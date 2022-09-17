{ pkgs, ... }:
{
    nixpkgs.config.packageOverrides = pkgs: {
        kicad = pkgs.kicad.overrideAttrs (previousAttrs: {
            base = previousAttrs.kicad.base.overrideAttrs (previousAttrs: {
                cmakeFlags = previousAttrs.cmakeFlags ++ [ "-DKICAD_USE_EGL=ON" ];
            });
        });
    };
}
