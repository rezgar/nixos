{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
  ];
  
  environment.variables.EDITOR = "urxvtc";

  services.xserver.desktopManager.default = "none";
  services.xserver.desktopManager.xterm.enable = false;

  programs.dconf.enable = true; # to avoid settings not being saved for some applications
  services.dbus.packages = [ pkgs.gnome3.dconf ];

  services.urxvtd.enable = true;

  # i3 configuration
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      i3status i3lock i3blocks rofi
#      rxvt_unicode
      urxvt_perls
    ];
  };
}
