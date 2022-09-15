{ config, ... }:
{
    config = {
        nixpkgs.config.allowUnfree = true;

        nix.extraOptions = ''
            experimental-features = nix-command
        '';

        nix.settings = {
            max-jobs = "auto";
            settings.auto-optimise-store = true;
        };
    };
}
