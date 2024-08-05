{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xorg.xeyes # test xwayland
    neofetch
    htop
    fzf
    ripgrep
    cliphist
    hyprpicker
    grim
    swappy
    slurp
    feh
    unzip
    wl-clipboard-rs
    killall
  ];
}
