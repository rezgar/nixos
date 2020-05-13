{ pkgs, config, ... }:
{
    imports = [
        # ../gaming.nix
        ../desktop/kde/nix
    ];

    environment.systemPackages = with pkgs; [
    ];
}
