import { LauncherButton } from "widgets/launcher/index";
import { Workspaces } from "widgets/hyprland/index";
import DateTime from "widgets/datetime/index";

export default function Bar(monitor = 0) {
  return Widget.Window({
    monitor,
    name: `bar-${monitor}`,
    class_name: "bar",
    exclusivity: "exclusive",
    anchor: ["top", "right", "left"],
    child: Widget.CenterBox({
      startWidget: Widget.Box({
        hexpand: true,
        children: [ LauncherButton(), Workspaces() ],
      }),
      centerWidget: Widget.Box({
        hpack: "center",
        children: [ ],
      }),
      endWidget: Widget.Box({
        hexpand: true,
        children: [ DateTime() ],
      }),
    }) 
  })
}
