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
        name = "rider-fhs";
        desktopName = "Rider";
        categories = [ "Development" ];
        comment = "JetBrains Rider is a new .NET IDE based on the IntelliJ platform and ReSharper. Rider supports .NET Core, .NET Framework and Mono based projects. This lets you develop a wide array of applications including .NET desktop apps, services and libraries, Unity games, ASP.NET and ASP.NET Core web applications.";
        exec = "rider-fhs";
        genericName = "A cross-platform .NET IDE based on the IntelliJ platform and ReSharper";
        icon = "rider";
        startupWMClass = "jetbrains-rider";
    };
in
{
    environment.systemPackages = [
        (pkgs.buildFHSUserEnv {
            name = "rider-fhs";

            targetPkgs = pkgs: (with pkgs; [
                jetbrains.rider
                (with dotnetCorePackages; combinePackages [
                    sdk_6_0
                    sdk_3_1
                ])
            ] ++ buildPackages);

            extraInstallCommands = ''
                # Create directories
                mkdir -p $out/share/applications $out/share/pixmaps

                # Create copy over .desktop file
                ln -s ${desktopItem}/share/applications/* $out/share/applications
                ln -s ${pkgs.jetbrains.rider}/share/pixmaps/* $out/share/pixmaps
            '';

            runScript = "rider";
        })
    ];
}
