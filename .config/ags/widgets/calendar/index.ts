export const isCalendarOpen = Variable(false);

const Calendar = Widget.Window({
  title: "calendar",
  anchor: ["top", "right"],
  layer: "overlay",
  class_name: "calendar",
  child: Widget.Box({
    class_name: "calendar-container",
    css: "padding: 10px;", // hack for getting the window to show up
    child: Widget.Revealer({
      revealChild: isCalendarOpen.bind(),
      transition: "slide_left",
      transitionDuration: 150,
      child: Widget.Calendar({
        class_name: "calendar-content",
        hexpand: true,
        showDayNames: true,
        showDetails: true,
        showHeading: true,
      }),
    }),
  }),
});

export default Calendar;
