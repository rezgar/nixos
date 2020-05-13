{ username, config, pkgs, ... }:
let
    username = import ./username.nix;
in
{
    imports = [
      (./users + "/${username}.nix")
    ];

    time.timeZone = "Europe/Chisinau";
    
    users.users.${username} = {
        isNormalUser = true;
            extraGroups = [
              "wheel" # enable 'sudo'
              "networkmanager"
              "docker"
            ];
    };
}
