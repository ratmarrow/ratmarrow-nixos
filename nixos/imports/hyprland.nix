{ config, pkgs, ...}:
let
  baseconfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseconfig; };
in {
  programs.hyprland = {
    enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    package = pkgs.hyprland;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    hyprland-protocols
    unstable.waybar
    rofi-wayland
    wlogout
    unstable.hyprlock
    networkmanager_dmenu
    unstable.dunst
    unstable.nautilus
    unstable.nwg-look
    grim
    slurp
    sox
  ];
}
