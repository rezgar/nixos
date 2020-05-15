{ config, pkgs, ... }: 

{
    environment.systemPackages = with pkgs; [
        vscode 
        awscli 
        tig
        nodejs nodePackages."@angular/cli"
    ];
}
