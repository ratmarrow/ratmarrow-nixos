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
      ./imports/hyprland.nix
      ./imports/locale.nix
      ./imports/network.nix
      ./imports/programs.nix
      ./users/ratmarrow.nix
      <home-manager/nixos>
    ];

  # Enable flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ratmarrow = {
    isNormalUser = true;
    description = "ratmarrow";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      vesktop
      piper
      mangohud
      fastfetch
      pfetch-rs
      alacritty
    ];
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
    
    home.stateVersion = "24.05";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
  ];

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
