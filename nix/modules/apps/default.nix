{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    google-chrome
    appflowy
    todoist-electron
    obsidian
    figma-linux
  ];
}
