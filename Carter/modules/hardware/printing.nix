{ config, pkgs, ... }:
{
    config = {
        # Enable CUPS to print documents.
        services.printing.enable = true;

        services.printing.drivers = [
            pkgs.hplipWithPlugin
            pkgs.gutenprint
        ];

        services.printing.browsing = true;
        services.printing.browsedConf = ''
            BrowseDNSSDSubTypes _cups,_print
            BrowseLocalProtocols all
            BrowseRemoteProtocols all
            CreateIPPPrinterQueues All

            BrowseProtocols all
        '';

        services.avahi = {
            enable = true;
            nssmdns = true;
        };
    };
}
