{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    slack skype tdesktop
  ];
}
