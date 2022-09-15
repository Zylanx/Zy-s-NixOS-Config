{ config, pkgs, ... }:
{
    config = {
        environment.shellAliases = let
            nano = "${pkgs.nano}/bin/nano";
            lsd = "${pkgs.lsd}/bin/lsd";
        in
        {
            edit-config = "sudo ${nano} /etc/nixos/configuration.nix";
            edit-hardware = "sudo ${nano} /etc/nixos/hardware-configuration.nix";
            switch-config = "sudo nixos-rebuild switch";

            snano = "sudo ${nano} ";
            nix-search = "nix --offline --extra-experimental-features \"nix-command flakes\" search nixpkgs ";

            ll = "${lsd} -l ";

            fucking-kill = "systemctl kill --signal=SIGKILL ";
        };
    };
};
