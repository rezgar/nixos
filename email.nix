{ pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    kmail
  ];
}
