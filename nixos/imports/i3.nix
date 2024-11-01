{ config, pkgs, ...}:
let
  baseconfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseconfig; };
in {
  services = {
    libinput.mouse.accelProfile = "flat";
    libinput.mouse.accelSpeed = "-0.5";
  
    xserver = {
      enable = true;
      
      desktopManager = { xterm.enable = false; };
      
      windowManager.i3 = {
      	enable = true;
      	extraPackages = with pkgs; [
      	  	i3blocks
      	  	i3status
      	  	i3lock-color
      	];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    rofi
    networkmanager_dmenu
    nemo
    xorg.xrandr
    inter
    feh
    flameshot
    polybar
    picom
  ];
}
