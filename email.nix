{ pkgs, ... }: 

#let 
#    mailspring = import 
#                 ( pkgs.fetchFromGitHub
#                     {
#                         owner = "Foundry376";
#                         repo = "Mailspring";
#                         rev = "refs/tags/1.7.4";
#                         sha256 = "1ifgs2s9wr98pf12bz5ckwcqp08rxv7f9bcs1p8w8llg3fqb9xm9";
#                     }
#                 ); 
#in
{
  environment.systemPackages = with pkgs; [
    kmail # mailspring
  ];
}
