{ config, pkgs, ... }:
{
    config = {
        nixpkgs.overlays = [
            (final: prev: { gitRepo = prev.gitRepo.overrideAttrs (old: { buildInputs = [ pkgs.python37 ]; }); })
        ];
    };
}
