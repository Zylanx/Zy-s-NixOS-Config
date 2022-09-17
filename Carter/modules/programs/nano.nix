{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        nano
    ];

    programs.nano.nanorc = ''
        set autoindent
        set tabstospaces
        set tabsize 4
        set linenumbers
    '';
}
