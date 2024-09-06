{ ... }:
{
  home.sessionVariables = {
    WALLPAPER = "~/wallpapers/tokyoAlley.png";
  };

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1,1920x1080@60,0x0,1"
    ];

    input = {
      kb_options = "caps:swapescape";
    };

    workspace = [
      "1, monitor:eDP-1, default:true"
      "2, monitor:eDP-1"
      "3, monitor:eDP-1"
      "4, monitor:eDP-1"
      "5, monitor:eDP-1"
    ];

    bind = [
      "$mainMod ALT, L, exec, hyprctl switchxkblayout at-translated-set-2-keyboard next"
    ];
  };
}
