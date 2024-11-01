# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  baseconfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseconfig; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./fonts.nix
      ./imports/audio.nix
      ./imports/bootloader.nix
      ./imports/display.nix
      ./imports/locale.nix
      ./imports/network.nix
      ./imports/programs.nix
      ./imports/i3.nix
      ./modules/nixos.nix
    ];

  nix.settings.auto-optimise-store = true;

  # Enable flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.

  users.mutableUsers = true;

  users.users = {
    ratmarrow = {
      isNormalUser = true;
      description = "ratmarrow";
      extraGroups = [ "networkmanager" "wheel"];
    };

    plasma = {
      isNormalUser = true;
      description = "plasma";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Flatpak.
  services.flatpak = {
    enable = true;

    update.auto.enable = true;
    update.onActivation = true;
    
    remotes = [
      { name = "flathub"; location = "https://flathub.org/repo/flathub.flatpakrepo"; }
    ];

    packages = [
      "io.github.zen_browser.zen"
     # "org.godotengine.GodotSharp"
      { flatpakref = "https://sober.vinegarhq.org/sober.flatpakref"; sha256 = "1pj8y1xhiwgbnhrr3yr3ybpfis9slrl73i0b1lc9q89vhip6ym2l"; }
    ];
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    gdu
    htop
    unstable.micro-full
    alacritty
    kitty
    piper
    vesktop
    prismlauncher
    fastfetch
    virtualbox
  ];

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

#  specialisation = {
#    hyprland = {
#      inheritParentConfig = true;
#      configuration = {
#        imports = [
#          ./imports/hyprland.nix 
#        ];
#      };
#    };
#    
#    plasma = {
#      inheritParentConfig = true;
#      configuration = {
#      
#        imports = [ 
#          ./imports/kde.nix 
#          <home-manager/nixos>
#        ];
#
#		home-manager.users.plasma = { pkgs, ... }: {
#		  imports = [ <plasma-manager/modules> ];
#
#		  programs.plasma = {
#		    enable = true;
#		  
#		    workspace.lookAndFeel = "org.kde.breezedark.desktop";	
#		  };
#
#		  home.stateVersion = "24.05";
#		};
#       
#      };
#    };
#
#    i3 = {
#      inheritParentConfig = true;
#      configuration = {
#      	imports = [ ./imports/i3.nix ];
#      };
#    };
#  };
}
