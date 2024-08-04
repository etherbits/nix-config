{ pkgs, ... }:

{
  imports = [ ./hyprland.nix ];

  home.packages = with pkgs; [
    iosevka
    (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; })
    ags
    anyrun
    gtklock
    xdg-desktop-portal-hyprland
  ];

  fonts.fontconfig.enable = true;
}
