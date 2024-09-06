{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "HDMI-A-1,2560x1440@144,0x0,1"
      "DP-2,3440x1440@75,2560x0,1"
    ];

    input = {
      sensitivity = 0;
      force_no_accel = true;
    };

    workspace = [
      "1, monitor:HDMI-A-1, default:true"
      "2, monitor:HDMI-A-1"
      "3, monitor:HDMI-A-1"
      "4, monitor:HDMI-A-1"
      "5, monitor:HDMI-A-1"
      "6, monitor:DP-2"
      "7, monitor:DP-2"
      "8, monitor:DP-2"
      "9, monitor:DP-2"
    ];

    bind = [
      "$mainMod ALT, L, exec, hyprctl switchxkblayout keychron-keychron-k6-pro next"
    ];
  };
}
