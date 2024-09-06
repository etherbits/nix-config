# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ ... }:

{
  # imports = [];

  networking.hostName = "nixos-laptop";

  services.upower = {
    enable = true;
  };
}

