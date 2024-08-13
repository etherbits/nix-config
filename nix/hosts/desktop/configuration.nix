# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, config, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ../../shared/etherbits-hyprland-amd/configuration.nix
      ./hardware-configuration.nix
    ];
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos-pc"; # Define your hostname.


  services.xserver.videoDrivers = ["nvidia"];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
	vaapiVdpau
	libvdpau-va-gl
	nvidia-vaapi-driver
      ];
    };
    pulseaudio.support32Bit = true;
  };


}

