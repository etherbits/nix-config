{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xorg.xeyes # test xwayland
    neofetch
    btop
    fzf
    ripgrep
    hyprpicker
    grim
    grimblast
    swappy
    slurp
    unzip
    unrar
    killall
    libnotify
    gvfs
  ];
}
