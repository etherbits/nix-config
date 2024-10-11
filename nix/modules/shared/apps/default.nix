{ pkgs, pkgs-unstable, ... }:

{
  home.packages = (with pkgs; [
    firefox
    google-chrome
    todoist-electron
    obsidian
    webcord
    obs-studio
    affine
    anki-bin
    qbittorrent
    libreoffice
    blender
    davinci-resolve
    okular
    inkscape
    krita
    jq
    syncthing
    reaper
  ])
  ++
  (with pkgs-unstable; [
    #
  ]);

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-mozc
    ];
  };

  xdg.desktopEntries = {
    zen = {
      name = "Zen";
      genericName = "Web Browser";
      icon = "/home/etherbits/.local/share/icons/my-icons/zen-white.svg";
      exec = "/home/etherbits/.local/share/applications/zen.AppImage";
      terminal = false;
      categories = [ "Network" "WebBrowser" ];
      mimeType = [ "text/html" "text/xml" ];
    };

    figma = {
      name = "Figma";
      genericName = "UI Design tool";
      icon = "/home/etherbits/.local/share/icons/my-icons/figma.svg";
      exec = "/home/etherbits/.local/share/applications/figma.AppImage";
      terminal = false;
      categories = [ "GUIDesigner" "Development" ];
    };
  };

}
