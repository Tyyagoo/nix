import { type BarWidget } from "widgets/bar/Bar";
import { mkOptions, opt } from "lib/options";
import { icon } from "lib/utils";
import { distro } from "lib/variables";

const options = mkOptions(OPTIONS, {
  autotheme: opt(false),
  wallpaper: opt(`/home/${USER}/.config/background`, { persistent: true }),
  theme: {
    dark: {
      primary: {
        bg: opt("#51a4e7"),
        fg: opt("#141414"),
      },
      error: {
        bg: opt("#e55f86"),
        fg: opt("#141414"),
      },
      bg: opt("#171717"),
      fg: opt("#eeeeee"),
      widget: opt("#eeeeee"),
      border: opt("#eeeeee"),
    },
    light: {
      primary: {
        bg: opt("#426ede"),
        fg: opt("#eeeeee"),
      },
      error: {
        bg: opt("#b13558"),
        fg: opt("#eeeeee"),
      },
      bg: opt("#fffffa"),
      fg: opt("#080808"),
      widget: opt("#080808"),
      border: opt("#080808"),
    },
  
    blur: opt(0),
    scheme: opt<"dark" | "light">("dark"),
    widget: { opacity: opt(94) },
    border: {
      width: opt(1),
      opacity: opt(96),
    },
  
    shadows: opt(true),
    padding: opt(7),
    spacing: opt(12),
    radius: opt(11),
  },

  transition: opt(200),

  font: {
    size: opt(13),
    name: opt("Iosevka Nerd Font"),
  },

  hyprland: {
    gaps: opt(2.4),
    inactiveBorder: opt("333333ff"),
    gapsWhenOnly: opt(false),
  },

  bar: {
    position: opt<"top" | "bottom">("top"),
    gaps: opt(20),
    layout: {
      start: opt<BarWidget[]>([
        "launcher",
        "media",
      ]),
      center: opt<BarWidget[]>([
        "workspaces",
      ]),
      end: opt<BarWidget[]>([
        "expander",
        "wallpaper",
        "datetime",
        "sidepanel",
      ]),
    },
    launcher: {
      action: opt(() => App.toggleWindow("applications")),
      colored: opt(true),
      icon: opt(icon(distro)),
    },
    workspaces: {
      persistent: opt(10),
    },
    datetime: {
      format: opt("  %T   %A %d %b"),
      action: opt(() => App.toggleWindow("calendar")),
    },
    sidepanel: {
      icon: opt(">>>"),
      action: opt(() => App.toggleWindow("sidepanel")),
    },
  },

  powermenu: {
    logout: opt("pkill Hyprland"),
    reboot: opt("systemctl reboot"),
    shutdown: opt("shutdown now"),
    layout: opt<"line" | "box">("line"),
    labels: opt(true),
  },

  sidepanel: {
    avatar: {
      image: opt(`/home/${Utils.USER}/.face`),
      size: opt(70),
    },
    width: opt(300),
    position: opt<"left" | "center" | "right">("right"),
    media: {
      monochromeIcon: opt(true),
      coverSize: opt(100),
    }
  },
});

globalThis["options"] = options;
export default options;
