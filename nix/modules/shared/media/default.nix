{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pavucontrol
    pamixer
    mpv
    cmus
    spotify
    spicetify-cli
    playerctl
    easyeffects
    jellyfin-mpv-shim
    feh
    qimgv
  ];
}
