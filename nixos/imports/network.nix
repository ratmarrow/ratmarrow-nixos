{ config, pkgs, ...}:
let
  baseconfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseconfig; };
in {
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
}
