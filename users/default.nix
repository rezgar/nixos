{ pkgs, config, ... }:
{
    imports = [
        ../desktop/kde/nix
    ];

    environment.systemPackages = with pkgs; [
    ];
}
