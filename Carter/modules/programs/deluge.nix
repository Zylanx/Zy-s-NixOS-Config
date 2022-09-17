{ config, pkgs, ... }:
{
    config = {
        nixpkgs.overlays = [
            (final: prev: { deluge = prev.deluge.overrideAttrs (old: { nativeBuildInputs = old.nativeBuildInputs ++ [ final.gobject-introspection ]; }); })
        ];
    };
}
