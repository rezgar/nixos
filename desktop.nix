{ libs, pkgs, config, ... }: 

{
  imports = [
    ./chat.nix
    ./email.nix
    ./coding.nix
  ];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    chromium xfce.mousepad
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
  hardware.pulseaudio.enable = true;
  
  # Enable CUPS to print document
  services.printing.enable = true;

  # Enable the X11 windowing system
  services.xserver = {
    enable = true;
    autorun = true;

    # Keyboard layouts
    layout = "us,ru(winkeys)";
    xkbOptions = "grp:toggle,grp_led:caps";
    xkbVariant = "winkeys";
    xkbModel = "microsoft";

    # Enable touchpad support
    libinput.enable = true;
    libinput.naturalScrolling = true;

    # Display Manager
    displayManager.sddm.enable = true;
  };
}
