# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ../../shared/etherbits-hyprland-amd/configuration.nix
      ./hardware-configuration.nix
    ];

  networking.hostName = "nixos-laptop"; # Define your hostname.
  services.upower = {
    enable = true;
  };
}

