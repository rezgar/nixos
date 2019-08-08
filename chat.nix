{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    skype pidgin 
  ];
}
