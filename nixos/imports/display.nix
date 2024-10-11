{ config, pkgs, ...}:
let
  baseconfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseconfig; };
in {
  hardware = {
    opengl.enable = true;

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "555.58";
        sha256_64bit = "sha256-bXvcXkg2kQZuCNKRZM5QoTaTjF4l2TtrsKUvyicj5ew=";
        settingsSha256 = "sha256-vWnrXlBCb3K5uVkDFmJDVq51wrCoqgPF03lSjZOuU8M=";
        persistencedSha256 = "sha256-lyYxDuGDTMdGxX3CaiWUh1IQuQlkI2hPEs5LI20vEVw=";
      };
    };
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager.gdm.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  nixpkgs.config.nvidia.acceptLicense = true;
}
