{ pkgs, config, ... }:
{
    imports = [
        ../desktop/kde/nix
        ../work.nix
        # ../gaming.nix
    ];

    environment.systemPackages = with pkgs; [
        mattermost-desktop
    ];
}
