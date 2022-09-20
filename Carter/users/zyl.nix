{ config, pkgs, lib, ... }:
{
    imports = [
        ../modules/programs/zsh.nix
        ../modules/programs/firefox.nix
        #../modules/programs/rider.nix
        #../modules/programs/clion.nix
        ../modules/programs/telegram.nix
        ../modules/programs/discord.nix
        #../modules/programs/kicad.nix
    ];

    config = {
        users.users.zyl = {
            description = "zyl";

            isNormalUser = true;

            extraGroups = [ "wheel" "networkmanager" "pipewire" "docker" "libvirtd" ];
            shell = pkgs.zsh;

            packages = with pkgs; [
                #kicad
                filelight
                rsync
                lsd
                hexyl
                minicom
                libreoffice
                krita
                pinta
                webtorrent_desktop
                teams
                onlykey
                onlykey-agent
                onlykey-cli
                kate
                kdevelop
               # jetbrains.pycharm-professional
                platformio
                (with dotnetCorePackages; combinePackages [
                    sdk_6_0
                    sdk_3_1
                ])
                google-chrome
                spotify
                easyeffects
                vlc
                noweb
                #texstudio
                #texmaker
                #gummi
                #lyx
                #texlive.combined.scheme-full
                rclone-browser
                obs-studio
                jq
            ];

            initialPassword = "hunter2";
        };

        programs.steam.enable = true;

        services.flatpak.enable = true;

        zyls = {
            programs = {
                firefox = {
                    enable = true;
                    autoStart = true;
                };

                discord = {
                    enable = true;
                    autoStart = true;
                };

                telegram = {
                    enable = true;
                    autoStart = false;
                };
            };
        };

        environment.sessionVariables = {
            BROWSER = "${config.zyls.programs.firefox.package}/bin/firefox";
            DEFAULT_BROWSER = "${config.zyls.programs.firefox.package}/bin/firefox";
        };

        # Enable automatic login for the user.
        services.xserver.displayManager.autoLogin.enable = true;
        services.xserver.displayManager.autoLogin.user = "zyl";
    };
}
