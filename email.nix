{ pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    thunderbird
  ];
}
