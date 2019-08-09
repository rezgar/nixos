{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    i3status i3lock i3blocks rofi
    rxvt_unicode
    urxvt_perls
  ];
  
  environment.variables.EDITOR = "urxvtc";

  services.xserver.desktopManager.default = "none";
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.windowManager.i3.enable = true;

  # i3 configuration
  services.xserver.windowManager.i3.config = {
    assigns = {
    };
  };
}
