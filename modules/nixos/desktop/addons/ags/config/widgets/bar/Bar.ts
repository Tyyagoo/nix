import options from "options"
import Datetime from "./widgets/Datetime"
import Launcher from "./widgets/Launcher"
import Sidepanel from "./widgets/Sidepanel"
import Workspaces from "./widgets/Workspaces"
import Wallpaper from "./widgets/Wallpaper"

const pos = options.bar.position.bind()
const gap = options.bar.gaps.bind()
const { start, center, end } = options.bar.layout
const fix = "min-width: 2px; min-height: 2px;"

export type BarWidget = keyof typeof widgets

const widgets = {
  datetime: Datetime,
  launcher: Launcher,
  sidepanel: Sidepanel,
  wallpaper: Wallpaper,
  workspaces: Workspaces,
  expander: () => Widget.Box({ hexpand: true }), 
} 


export default function Bar(monitor = 0) {
  return Widget.Window({
    monitor,
    name: `bar-${monitor}`,
    class_name: "bar",
    exclusivity: "exclusive",
    anchor: pos.as(p => [p, "right", "left"]), 
    child: Widget.CenterBox({
      css: fix, // margin: 10px ${g}px 0px ${g}px;`),
      startWidget: Widget.Box({
        hexpand: true,
        css: gap.as(g => `margin-left: ${g}px;`),
        children: start.bind().as(xs => xs.map(w => widgets[w]())),
      }),
      centerWidget: Widget.Box({
        hpack: "center",
        children: center.bind().as(xs => xs.map(w => widgets[w]())),
      }),
      endWidget: Widget.Box({
        hexpand: true,
        css: gap.as(g => `margin-right: ${g}px;`),
        children: end.bind().as(xs => xs.map(w => widgets[w]())),
      }),
    }) 
  })
}
