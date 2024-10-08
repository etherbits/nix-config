import Bar from "./widgets/bar/index";
import AppLauncher from "./widgets/appLauncher/index";
import Calendar from "widgets/calendar/index";
import NotificationPopups from "widgets/notificationPopups/index";
import PowerMenu from "widgets/powerMenu/index";
import { forMonitors } from "utils/helpers";

const css = `${App.configDir}/styles/style.css`;

const styleDirectories = [
  `${App.configDir}/styles`,
  `${App.configDir}/widgets`,
];

styleDirectories.map((dir) =>
  Utils.monitorFile(dir, () => {
    App.resetCss();
    App.applyCss(css);
  }),
);

App.applyCss(css);

App.config({
  windows: [
    ...forMonitors(Bar),
    ...forMonitors(NotificationPopups),
    Calendar,
    AppLauncher,
    PowerMenu,
  ],
});

export {};
