{ libs, pkgs, ... }:
{
  imports = [
    ./desktop.nix
    ./desktop/i3.nix
    ./work.nix
    ./chat.nix
    ./email.nix
  ];
}
