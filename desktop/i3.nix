{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    i3status i3lock i3blocks rofi
    rxvt_unicode
    urxvt_perls
  ];
  
  services.xserver.desktopManager.default = "none";
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.windowManager.i3.enable = true;

  environment.variables.EDITOR = "urxvtc";
}
