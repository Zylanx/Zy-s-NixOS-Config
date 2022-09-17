{ config, pkgs, ... }:
{
    config = {
        environment.interactiveShellInit = ''
            # The next line updates PATH for the Google Cloud SDK.
            if [ -f '/home/zyl/gcloudEnv/google-cloud-sdk/path.bash.inc' ]; then . '/home/zyl/gcloudEnv/google-cloud-sdk/path.bash.inc'; fi

            # The next line enables shell command completion for gcloud.
            if [ -f '/home/zyl/gcloudEnv/google-cloud-sdk/completion.bash.inc' ]; then . '/home/zyl/gcloudEnv/google-cloud-sdk/completion.bash.inc'; fi
        '';

        environment.systemPackages = [
            gcloud
        ];
    };
}
