{ config, pkgs, ... }:

let
    username = "rezgar";
in {
    imports = [
        ./desktop/kde/nix
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

    environment.systemPackages = with pkgs; [
        mattermos-desktop
    ];
}
