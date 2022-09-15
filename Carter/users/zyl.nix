{ config, pkgs, ... }:
{
    imports = [
        ../modules/programs/zsh.nix
    ];

    config = {
        users.users.zyl = {
            description = "zyl";

            isNormalUser = true;

            extraGroups = [ "wheel" "networkmanager" "pipewire" "docker" "libvirtd" ];
            shell = pkgs.zsh;

            packages = [

            ];

            initialPassword = "hunter2";
        };

        # Enable automatic login for the user.
        services.xserver.displayManager.autoLogin.enable = true;
        services.xserver.displayManager.autoLogin.user = "zyl";
    };
}
