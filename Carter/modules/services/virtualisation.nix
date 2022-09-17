{ config, pkgs, ... }:
{
    config = {
        virtualisation = {
            docker.enable = true;

            libvirtd = {
                enable = true;

                qemu = {
                    runAsRoot = false;
                    ovmf.enable = true;
                    swtpm.enable = true;
                };

                onBoot = "ignore";
                onShutdown = "shutdown";
            };

            kvmgt.enable = true;
        };
    };
}
