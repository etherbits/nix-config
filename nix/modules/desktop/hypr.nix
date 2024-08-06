{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    monitor = "eDP-1,1920x1080@60,0x0,1";
    source = [
      "~/.config/hypr/binds.conf"
      "~/.config/hypr/inputs.conf"
      "~/.config/hypr/ui.conf"
      "~/.config/hypr/software.conf"
    ];
  };
}
