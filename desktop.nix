{ libs, pkgs, config, ... }: 

{
  imports = [
    ./chat.nix
    ./email.nix
    ./coding.nix
  ];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    chromium
  ];

  fonts.fonts = with pkgs; [
    hermit
    source-code-pro
    dejavu_fonts
    powerline-fonts # urxvt fonts (i3)
    font-awesome_4 font-awesome_5
  ];

  # Enable sound
  sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system
  services.xserver.enable = true;
  services.xserver.autorun = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eugosign:e";

  # Enable touchpad support
  services.xserver.libinput.enable = true;
  services.xserver.libinput.naturalScrolling = true;

  # Display Manager
  services.xserver.displayManager.sddm.enable = true;

  # Enable CUPS to print document
  services.printing.enable = true;
}
