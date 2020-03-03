{ config, pkgs, ... }:

# Use your own OS user name
let
	username = "user";
in {
	# TODO: Probably add to imports, rather than rewrite imports
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
}
