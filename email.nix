{ pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    inboxer
  ];
}
