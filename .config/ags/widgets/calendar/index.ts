const WINDOW_NAME = `ags-calendar`;

const Calendar = Widget.Window({
  name: WINDOW_NAME,
  anchor: ["top", "right"],
  layer: "overlay",
  class_name: "calendar",
  keymode: "exclusive",
  visible: false,
  setup: (self) => {
    self.keybind("Escape", () => {
      App.closeWindow(WINDOW_NAME);
    });
  },
  child: Widget.Box({
    class_name: "calendar-container",
    css: "padding: 10px;", // hack for getting the window to show up
    child: Widget.Calendar({
      class_name: "calendar-content",
      hexpand: true,
      showDayNames: true,
      showDetails: true,
      showHeading: true,
    }),
  }),
});
export default Calendar;
