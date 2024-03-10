import options from "options"
import Datetime from "./widgets/Datetime"
import Launcher from "./widgets/Launcher"
import Workspaces from "./widgets/Workspaces"

const pos = options.bar.position.bind()
const { start, center, end } = options.bar.layout

export type BarWidget = keyof typeof widgets

const widgets = {
  datetime: Datetime,
  launcher: Launcher,
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
      css: "min-width: 2px; min-height: 2px;",
      startWidget: Widget.Box({
        hexpand: true,
        children: start.bind().as(xs => xs.map(w => widgets[w]())),
      }),
      centerWidget: Widget.Box({
        hpack: "center",
        children: center.bind().as(xs => xs.map(w => widgets[w]())),
      }),
      endWidget: Widget.Box({
        hexpand: true,
        children: end.bind().as(xs => xs.map(w => widgets[w]())),
      }),
    }) 
  })
}
