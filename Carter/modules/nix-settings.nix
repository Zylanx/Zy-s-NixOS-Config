{ config, ... }:
{
    config = {
        nixpkgs.config.allowUnfree = true;

        nix.extraOptions = ''
            experimental-features = nix-command
        '';

        nix.settings = {
            max-jobs = "auto";
            auto-optimise-store = true;
        };
    };
}
