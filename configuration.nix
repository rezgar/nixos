{ config, pkgs, ... }:

{
  # TODO: Import packages directly from GitHub using fetchTarball or fetchGit via nixpgks=....

  imports =
    [ # Include the results of the hardware scan.
	./hardware-configuration.nix
	./desktop.nix
	./chat.nix
	./email.nix
	./coding.nix
	./user.nix
#	(import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos") 
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Chisinau";

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    wget vim
    ntp # time synchronization
    git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Security key management
  services.gnome3.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  security.pam.services.sddm.startSession = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
