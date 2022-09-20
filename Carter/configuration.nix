# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:
{
    imports = [
        ./hardware-configuration.nix  # Include the results of the hardware scan.

        ./modules/nix-settings.nix

        ./users/zyl.nix

        ./modules/desktops/gnome.nix
        ./modules/desktops/plasma.nix
        ./modules/desktops/pantheon.nix

        ./modules/hardware/printing.nix
        ./modules/hardware/keymap.nix
        ./modules/hardware/touchpad.nix

        ./modules/programs/zsh.nix
        ./modules/programs/nano.nix
        #./modules/programs/rider.nix
        #./modules/programs/clion.nix
        ./modules/programs/firefox.nix
        ./modules/programs/discord.nix
        ./modules/programs/telegram.nix
        #./modules/programs/kicad.nix
        ./modules/programs/deluge.nix
        #./modules/programs/gcloud.nix
        #./modules/programs/repo.nix


        ./modules/sound

        ./modules/services/onedrive.nix
        ./modules/services/virtualisation.nix

        ./modules/misc/aliases.nix
        ./modules/misc/fonts.nix
    ];

    nixpkgs.overlays = [
        (final: prev: { my-kicad = pkgs.callPackage ./pkg/kicad { }; })
    ];

    # Bootloader.
    boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        
        loader = {
            # Use the systemd-boot EFI boot loader.
            systemd-boot = {
                enable = true;
                configurationLimit = 5;
            };

            efi = {
                canTouchEfiVariables = true;
                efiSysMountPoint = "/boot";
            };
        };

        kernelParams = [ "quiet" ];
        consoleLogLevel = 1;
        initrd.verbose = false;
        plymouth.enable = true;
    };

    systemd.extraConfig = ''
        DefaultTimeoutStopSec=5s
    '';

    # Probably move into user services
    security.pam.u2f =
    {
        enable = true;
        control = "sufficient";
        cue = true;
    };

    zramSwap = {
        enable = true;
        priority = 2;
        memoryPercent = 50;
    };

    services.dbus.enable = true;

    networking.hostName = "carter"; # Define your hostname.

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Australia/Melbourne";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_AU.utf8";

    #zyls.desktops.pantheon.enable = true;
    zyls.desktops.gnome.enable = true;

    qt5 = {
      style = "adwaita-dark";
    };

    # Configure keymap in X11
    services.xserver = {
        layout = "au";
        xkbVariant = "";
    };

    programs.dconf.enable = true;

    xdg = {
        portal = {
            enable = true;
            
            #extraPortals = (with pkgs; [
            #    xdg-desktop-portal-gtk
            #    xdg-desktop-portal-kde
            #]);
            
            gtkUsePortal = true;
        };
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        vim
        nano
        git
        wget
        killall
        dialog
        pciutils
        wayland-utils
        vulkan-tools
        rclone
        wayland
        docker
        bash
        virtmanager
        
        adwaita-qt
        gnome.adwaita-icon-theme
    ];


    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "22.05"; # Did you read the comment?
}
