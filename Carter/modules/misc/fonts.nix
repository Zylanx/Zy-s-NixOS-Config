{ config, pkgs, ... }:
{
    config = {
        fonts.fonts = [
            pkgs.fira-code
            pkgs.fira-code-symbols
            pkgs.meslo-lgs-nf
        ];

        fonts.fontDir.enable = true;
    };
}
