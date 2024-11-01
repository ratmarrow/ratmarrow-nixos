{ config, pkgs, ...}:
let
  baseconfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseconfig; };
in {
  programs.sway = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
  	waybar
  	rofi-wayland
  	networkmanager_dmenu
  	mako
  	nemo
  	grim
  	slurp
  	wl-clipboard
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
