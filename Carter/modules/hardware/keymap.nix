{ config, ... }:
{
    config = {
        # Configure keymap in X11
        services.xserver = {
            layout = "au";
            xkbVariant = "";
        };
    };
}
