{ config, pkgs, ...}:
let
  baseconfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseconfig; };
in {
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    unstable.easyeffects
    unstable.pavucontrol
  ];
}
