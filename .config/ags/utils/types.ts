import Gdk from "types/@girs/gdk-3.0/gdk-3.0";

export type Key = keyof {
  [K in keyof typeof Gdk as K extends `KEY_${infer U}` ? U : never]: number;
};
