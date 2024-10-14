{ config, pkgs, ...}:
let
  baseconfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseconfig; };
in {
  services.ratbagd.enable = true;
  services.printing.enable = false;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  programs.gamescope = {
    enable = true;
    package = unstable.pkgs.gamescope;
  };

  environment.systemPackages = with pkgs; [
	unstable.pinta
	mangohud
  ];

  nixpkgs.config.packageOverrides = pkgs: { 
    steam = pkgs.steam.override { 
      extraPkgs = pkgs: with pkgs; [ 
        libgdiplus 
        keyutils 
        libkrb5 
        libpng 
        libpulseaudio 
        libvorbis 
        stdenv.cc.cc.lib 
        xorg.libXcursor 
        xorg.libXi 
        xorg.libXinerama 
        xorg.libXScrnSaver 
      ]; 
    }; 
  };
}
