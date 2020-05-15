{ config, pkgs, ... }: 
{
  system.activationScripts = {
    hubstaff = {
      deps = [];
      text = ''
        source ${config.system.build.setEnvironment}
        bash <(curl -s https://hubstaff-production.s3.amazonaws.com/downloads/HubstaffClient/Builds/Release/1.5.11-137ba6a6/Hubstaff-1.5.11-137ba6a6.sh)
      '';
    };
  };
}
