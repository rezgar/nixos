{ pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    # There's no visually appealing mail client that works on all platforms. "kmail" is good for KDE, but doesn't work with i3. It's best to use different ones per DM
  ];
}
