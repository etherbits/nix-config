import Gdk from "types/@girs/gdk-3.0/gdk-3.0";
import Gtk from "types/@girs/gtk-3.0/gtk-3.0";

export function forMonitors(widget: (monitor: number) => Gtk.Window) {
  const n = Gdk.Display.get_default()?.get_n_monitors() || 1;
  return range(n, 0).flatMap(widget);
}

export function range(length: number, start = 1) {
  return Array.from({ length }, (_, i) => i + start);
}
