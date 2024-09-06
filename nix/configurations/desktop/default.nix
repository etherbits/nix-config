# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ ... }:

{
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "nixos-pc"; # Define your hostname.


  fileSystems."/mnt/store" =
    {
      device = "/dev/sdb2";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" ];
    };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1"; # needed for hyprland to display cursor on Nvidia gpu
    # LD_LIBRARY_PATH = "$(nix build --print-out-paths --no-link nixpkgs#libGL)/lib";
  };
}

