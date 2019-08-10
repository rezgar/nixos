{ lib, config, pkgs, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  imports = [
    ./package-configs/vim.nix
    ./package-configs/i3.nix
    ./package-configs/urxvt.nix
  ];
}
