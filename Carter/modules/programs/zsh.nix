{ config, pkgs, ... }:
{
    config = {
        environment.systemPackages = [
            pkgs.zsh
        ];

        environment.shells = [ pkgs.zsh ];

        programs.zsh = {
            enable = true;

            histSize = 10000;

            enableCompletion = true;
            autosuggestions.enable = true;
            syntaxHighlighting.enable = true;

            ohMyZsh = {
            enable = true;

            customPkgs = [
                (pkgs.stdenv.mkDerivation rec {
                    name = "powerlevel10k";

                    src = null;

                    inherit (pkgs.zsh-powerlevel10k) buildInputs propagatedBuildInputs;

                    dontBuild = true;
                    dontUnpack = true;

                    installPhase = ''
                        mkdir -p $out/share/zsh/themes/powerlevel10k
                        cp -r ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/* $out/share/zsh/themes/powerlevel10k
                    '';
                })
            ];

            theme = "powerlevel10k/powerlevel10k";
            };
        };
    };
}
