{ config, pkgs, ... }:
let
  baseconfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseconfig; };
in {
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
}
