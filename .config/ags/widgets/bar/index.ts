import { isCalendarOpen } from "widgets/calendar/index";

const hyprland = await Service.import("hyprland");
const notifications = await Service.import("notifications");
const mpris = await Service.import("mpris");
const audio = await Service.import("audio");
const battery = await Service.import("battery");
const systemtray = await Service.import("systemtray");

const date = Variable("", {
  poll: [1000, 'date "+%H:%M:%S %b %e"'],
});

function Workspaces() {
  const activeId = hyprland.active.workspace.bind("id");
  const workspaces = hyprland.bind("workspaces").as((ws) =>
    ws
      .sort((wa, wb) => wa.id - wb.id)
      .map(({ id }) =>
        Widget.Button({
          on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
          child: Widget.Label(`${id}`),
          class_name: activeId.as(
            (i) => `${i === id ? `w${id} focused` : `w${id}`}`,
          ),
        }),
      ),
  );

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  });
}

function ClientTitle() {
  return Widget.Label({
    class_name: "client-title",
    label: hyprland.active.client.bind("title"),
    truncate: "end",
    maxWidthChars: 32,
  });
}

function Clock() {
  return Widget.Button({
    on_clicked: () => {
      isCalendarOpen.setValue(!isCalendarOpen.value);
    },
    child: Widget.Label({
      class_name: "clock",
      label: date.bind(),
    }),
  });
}

// we don't need dunst or any other notification daemon
// because the Notifications module is a notification daemon itself
function Notification() {
  const popups = notifications.bind("popups");
  let last = "";
  const hasOne = popups.as((p) => p.length > 0);
  return Widget.Box({
    class_name: hasOne.as(
      (has) => `bar-notification ${has ? "visible" : "invisible"}`,
    ),
    children: [
      Widget.Icon({
        icon: "preferences-system-notifications-symbolic",
      }),
      Widget.Label({
        truncate: "end",
        maxWidthChars: 24,
        label: popups.as((p) => {
          if (hasOne) {
            last = p[0]?.summary ?? last;
            return last;
          } else {
            return last;
          }
        }),
      }),
    ],
  });
}

function Media() {
  const label = Utils.watch("", mpris, "player-changed", () => {
    if (mpris.players[0]) {
      const { track_artists, track_title } = mpris.players[0];
      return `${track_artists.join(", ")} - ${track_title}`;
    } else {
      return "Nothing is playing";
    }
  });

  return Widget.Button({
    class_name: "media",
    on_primary_click: () => mpris.getPlayer("")?.playPause(),
    on_scroll_up: () => mpris.getPlayer("")?.next(),
    on_scroll_down: () => mpris.getPlayer("")?.previous(),
    child: Widget.Label({
      label,
      justification: "right",
      truncate: "end",
      maxWidthChars: 32,
    }),
  });
}

function Mic() {
  const icons = {
    active: "microphone-sensitivity-high",
    muted: "microphone-sensitivity-muted",
  };

  function getIcon() {
    const icon = audio.microphone.is_muted ? "muted" : "active";
    return icons[icon];
  }

  return Widget.Icon({
    icon: Utils.watch(getIcon(), audio.microphone, getIcon),
    tooltipText: audio.microphone
      .bind("is_muted")
      .as((is_muted) =>
        is_muted ? "Microphone is muted" : "Microphone is unmuted",
      ),
    class_name: "icon mic_icon",
  });
}

function Volume() {
  const icons = {
    101: "overamplified",
    67: "high",
    34: "medium",
    1: "low",
    0: "muted",
  };

  function getIcon() {
    const icon = audio.speaker.is_muted
      ? 0
      : [101, 67, 34, 1, 0].find(
          (threshold) => threshold <= audio.speaker.volume * 100,
        );

    return `audio-volume-${icons[icon ?? 0]}-symbolic`;
  }

  const icon = Widget.Icon({
    icon: Utils.watch(getIcon(), audio.speaker, getIcon),
    class_name: "icon",
  });

  const slider = Widget.Slider({
    hexpand: true,
    draw_value: false,
    class_name: "slider",
    on_change: ({ value }) => (audio.speaker.volume = value),
    setup: (self) =>
      self.hook(audio.speaker, () => {
        self.value = audio.speaker.volume || 0;
      }),
  });

  return Widget.Box({
    class_name: "volume",
    tooltipText: audio.speaker
      .bind("volume")
      .as((vol) => `${(vol * 100).toFixed(0)}% volume`),
    children: [icon, slider],
  });
}

function BatteryLabel() {
  const value = battery.bind("percent").as((p) => (p > 0 ? p / 100 : 0));
  const icon = battery
    .bind("percent")
    .as((p) => `battery-level-${Math.floor(p / 10) * 10}-symbolic`);

  return Widget.Box({
    class_name: "battery",
    visible: battery.bind("available"),
    tooltipText: battery.bind("percent").as((p) => `${p}% remaining`),
    children: [
      Widget.Icon({ icon, class_name: "icon" }),
      Widget.LevelBar({
        vpack: "center",
        value,
      }),
    ],
  });
}

function SysTray() {
  const items = systemtray.bind("items").as((items) =>
    items.map((item) =>
      Widget.Button({
        child: Widget.Icon({ icon: item.bind("icon") }),
        on_primary_click: (_, event) => item.activate(event),
        on_secondary_click: (_, event) => item.openMenu(event),
        tooltip_markup: item.bind("tooltip_markup"),
      }),
    ),
  );

  return Widget.Box({
    spacing: 4,
    children: items,
  });
}

// layout of the bar
function Left() {
  return Widget.Box({
    spacing: 10,
    children: [Workspaces(), ClientTitle()],
  });
}

function Center() {
  return Widget.Box({
    spacing: 10,
    children: [Notification()],
  });
}

function Right() {
  return Widget.Box({
    hpack: "end",
    spacing: 10,
    children: [Media(), SysTray(), Mic(), Volume(), BatteryLabel(), Clock()],
  });
}

function Bar(monitor = 0) {
  return Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    margins: [12, 12, 0, 12],
    class_name: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(),
      center_widget: Center(),
      end_widget: Right(),
    }),
  });
}

export default Bar;
