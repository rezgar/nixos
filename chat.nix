{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    slack skype pidgin tdesktop
  ];
}
