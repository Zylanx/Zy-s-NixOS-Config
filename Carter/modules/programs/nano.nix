{ config, pkgs, ... }:
{
    environment.systemPackages = [
        nano
    ];

    programs.nano.nanorc = ''
        set autoindent
        set tabstospaces
        set tabsize 4
        set linenumbers
    '';
}
