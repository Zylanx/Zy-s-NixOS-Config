# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
    imports = [
        ./hardware-configuration.nix  # Include the results of the hardware scan.

        ./modules/nix-settings.nix

        ./users/zyl.nix

        ./modules/desktops/gnome.nix

        ./modules/hardware/printing.nix
        ./modules/hardware/keymap.nix
        ./modules/hardware/touchpad.nix

        ./modules/programs/zsh.nix
        ./modules/programs/nano.nix

        ./modules/sound

        ./modules/services/OneDrive.nix
    ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";

    networking.hostName = "carter"; # Define your hostname.

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Australia/Adelaide";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_AU.utf8";

    # Configure keymap in X11
    services.xserver = {
      layout = "au";
      xkbVariant = "";
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    ];


    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "22.05"; # Did you read the comment?
}
