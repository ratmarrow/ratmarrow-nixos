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
      ./imports/hyprland.nix
      ./imports/kde.nix
      <home-manager/nixos>
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

	ratmarrow-kde = {
      isNormalUser = true;
      description = "ratmarrow-kde";
      extraGroups = [ "networkmanager" "wheel" ];
	};
  };

  # Home Manager.
  home-manager.users.ratmarrow = { pkgs, ... }: {
    gtk = {
      enable = true;
      theme = {
        name = "vimix-gtk-themes";
        package = pkgs.vimix-gtk-themes.override {
          themeVariants = [ "ruby" ];
          colorVariants = [ "dark" ];
          sizeVariants = [ "compact" ];
          tweaks = [ "flat" ];
        };
      };

      iconTheme = {
        name = "vimix-icon-themes";
        package = pkgs.vimix-icon-theme.override {
          colorVariants = [ "Ruby" ];
        };
      };
    };

    home.packages = with pkgs; [
      unstable.waybar
      rofi-wayland
      wlogout
      unstable.hyprlock
      networkmanager_dmenu
      unstable.dunst
      unstable.nemo
      unstable.nwg-look
      grim
      slurp
      sox	
    ];
    
    home.stateVersion = "24.05";
  };

  home-manager.users.ratmarrow-kde = { pkgs, ... }: {
	imports = [ <plasma-manager/modules> ];
  
  	home.stateVersion = "24.05";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Flatpak.
  services.flatpak = {
    enable = true;

    uninstallUnmanaged = true;
    
    remotes = [
      { name = "flathub"; location = "https://flathub.org/repo/flathub.flatpakrepo"; }
    ];

    packages = [
      "io.github.zen_browser.zen"
     # "org.godotengine.GodotSharp"
    ];
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    gdu
    unstable.micro-full
    kitty
    piper
    vesktop
    prismlauncher
    pfetch-rs
    virtualbox
  ];

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
