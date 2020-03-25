{ config, pkgs, ... }:

# Use your own OS user name
let
    username = "user";
in {
    # Add/modify existing default or custom imports 
    imports = [
        ./desktop/kde/nix
    ];

    # Set your time zone.
    time.timeZone = "Europe/Chisinau";
    
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${username} = {
        isNormalUser = true;
            extraGroups = [
              "wheel" # enable 'sudo'
              "networkmanager"
              "docker"
            ];
    };

    environment.systemPackages = with pkgs; [
        # Insert your custom packages here (separated with a space)
    ];
}
