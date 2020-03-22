{ config, pkgs, ... }: 

{
  environment.systemPackages = with pkgs; [
    vscode awscli nodejs
  ];
}
