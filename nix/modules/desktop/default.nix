{ pkgs, ... }:

{
  imports = [ ./hyprland.nix ];

  home =
    {
      packages = with pkgs; [
        iosevka
        (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; })
        ags
        anyrun
        gtklock
        xdg-desktop-portal-hyprland
      ];

      pointerCursor = {
        gtk.enable = true;
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
        size = 16;
      };
    };

  fonts.fontconfig.enable = true;


}
