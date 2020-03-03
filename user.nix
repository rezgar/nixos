{ config, pkgs, ... }:

# Use your own OS user name
let
	username = "rezgar";
in {
	# Add/modify existing default or custom imports 
	imports = [
		./desktop/plasma5/nix
		./work/crossover.nix
	];

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.${username} = {
	    isNormalUser = true;
	    	extraGroups = [
	    	  "wheel" # enable 'sudo'
	          "networkmanager"
	    	];
	};

#	services.xserver.displayManager.sddm.autoLogin = {
#		enable = true;
#		user = "${username}";
#        };
}
