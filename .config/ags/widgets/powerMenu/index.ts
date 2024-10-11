import { Key } from "utils/types";

const WINDOW_NAME = "ags-power-menu";

const powerOptions: {
  icon: string;
  label: string;
  cmd: string;
  key?: Key;
}[] = [
  {
    icon: "system-shutdown-symbolic",
    label: "Shutdown",
    cmd: "shutdown 0",
    key: "s",
  },
  {
    icon: "media-playback-pause",
    label: "Suspend",
    cmd: "systemctl suspend",
    key: "p",
  },
  {
    icon: "system-reboot-symbolic",
    label: "Reboot",
    cmd: "systemctl reboot",
    key: "r",
  },
  {
    icon: "system-lock-screen-symbolic",
    label: "Lock",
    cmd: "gtklock",
    key: "l",
  },
  {
    icon: "system-log-out-symbolic",
    label: "Log Out",
    cmd: "hyprctl dispatch exit",
    key: "o",
  },
];

const PowerMenu = Widget.Window({
  name: WINDOW_NAME,
  className: "power-menu",
  setup: (self) => {
    self.keybind("Escape", () => {
      App.closeWindow(WINDOW_NAME);
    });

    powerOptions.forEach((opt) => {
      if (!opt.key) return;

      self.keybind(opt.key, () => {
        Utils.execAsync(opt.cmd);
        App.closeWindow(WINDOW_NAME);
      });
    });
  },
  visible: false,
  keymode: "exclusive",
  child: Widget.Box({
    className: "power-menu-box",
    children: powerOptions.map((opt) =>
      Widget.Button({
        on_clicked: () => {
          App.closeWindow(WINDOW_NAME);
          Utils.execAsync(opt.cmd);
        },
        child: Widget.Box({
          vertical: true,
          children: [
            Widget.Icon({ icon: opt.icon, size: 48 }),
            Widget.Label(
              opt.key ? `${opt.label} [${opt.key.toUpperCase()}]` : opt.label,
            ),
          ],
        }),
      }),
    ),
  }),
});

export default PowerMenu;
