{ config, pkgs, ... }:
{
    config = {
        systemd.user.services = {
            OneDrive = {
                description = "OneDrive RClone mount daemon";
                wants = [ "NetworkManager-wait-online.service" ];
                after = [ "NetworkManager-wait-online.service" ];

                wantedBy = [ "default.target" ];

                serviceConfig = {
                    ExecStartPre = "${pkgs.coreutils-full}/bin/mkdir -p %h/OneDrive/";
                    ExecStart = "${pkgs.rclone}/bin/rclone mount \"onedrive:/\" %h/OneDrive/ --vfs-cache-mode full";
                    ExecStop = "/run/wrappers/bin/fusermount -u %h/OneDrive/";
                    Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
                };
            };
        };
    };
}
