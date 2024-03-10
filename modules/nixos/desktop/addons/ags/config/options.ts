import { type BarWidget } from "widgets/bar/Bar";
import { mkOpt } from "lib/options";

const options = {
  bar: {
    position: mkOpt<"top" | "bottom">("top"),
    gaps: mkOpt(20),
    layout: {
      start: mkOpt<BarWidget[]>([
        "launcher",
      ]),
      center: mkOpt<BarWidget[]>([
        "workspaces",
      ]),
      end: mkOpt<BarWidget[]>([
        "expander",
        "datetime",
      ]),
    },
    launcher: {
      action: mkOpt(() => App.toggleWindow("applications")),
      colored: mkOpt(true),
      icon: mkOpt(" 󱄅 "),
    },
    workspaces: {
      persistent: mkOpt(10),
    },
    datetime: {
      format: mkOpt("  %T   %A %d %b"),
      action: mkOpt(() => App.toggleWindow("calendar")),
    },
  },
};

globalThis["options"] = options;
export default options;
