{ pkgs, config, ... }:
{
    imports = [
        ../desktop/kde/nix
        ../work.nix
    ];

    environment.systemPackages = with pkgs; [
    ];
}
