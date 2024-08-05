{ pkgs, ... }:

{
  imports = [ ./hypr.nix ];

  home =
    {
      packages = with pkgs; [
        iosevka
        (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; })
        xfce.thunar
        anyrun
        gtklock
        xdg-desktop-portal-hyprland
        swww
      ];

      pointerCursor = {
        gtk.enable = true;
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
        size = 16;
      };
    };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };

  programs.ags = {
    enable = true;

    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  fonts.fontconfig.enable = true;


}
