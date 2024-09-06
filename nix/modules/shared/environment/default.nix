{ pkgs, ... }:

{
  imports = [ ./hypr.nix ./fonts.nix ./theme.nix ./ags.nix ];

  home =
    {
      packages = with pkgs; [
        xfce.thunar
        anyrun
        gtklock
        xdg-desktop-portal-hyprland
        swww
        clipse
        smile
      ];
    };
}
