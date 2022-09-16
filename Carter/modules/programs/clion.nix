{ config, pkgs, ... }:
let
    buildPackages = with pkgs; [
        coreutils
        binutils
        glibc
        gcc
        cmake
        ninja
        zlib
        bash
    ];

    desktopItem = pkgs.makeDesktopItem {
        name = "clion";
        desktopName = "CLion";
        categories = [ "Development" ];
        comment = "Enhancing productivity for every C and C++ developer on Linux, macOS and Windows.";
        exec = "clion-fhs";
        genericName = "C/C++ IDE. New. Intelligent. Cross-platform";
        icon = "clion";
        startupWMClass = "jetbrains-clion";
    };
in
{
    environment.systemPackages = [
        (pkgs.buildFHSUserEnv {
            name = "clion-fhs";

            targetPkgs = pkgs: (with pkgs; [
                platformio
                pkg-config
                jetbrains.clion
                conan
                mpi

                ocl-icd
                opencl-headers
                opencl-clhpp
            ] ++ buildPackages);

            extraInstallCommands = ''
            # Create directories
            mkdir -p $out/share/applications $out/share/pixmaps

            # Create copy over .desktop file
            ln -s ${desktopItem}/share/applications/* $out/share/applications
            ln -s ${pkgs.jetbrains.clion}/share/pixmaps/* $out/share/pixmaps
            '';

            runScript = "clion";
        })
    ];
}
