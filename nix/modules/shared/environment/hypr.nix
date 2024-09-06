{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    source = [
      "~/.config/hypr/extra.conf"
    ];
  };
}
