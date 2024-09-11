{ pkgs, ... }:

{
  home = {
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = 11;
    };

    sessionVariables = {
      WALLPAPER = "~/wallpapers/tokyoAlley.png";
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
}
