{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-mpv-shim
    pavucontrol
    pamixer
    mpv
    spotify
    spicetify-cli
    playerctl
  ];
}
