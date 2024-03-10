import options from "options";
import { range } from "lib/utils";
import PanelButton from "./PanelButton";

const hyprland = await Service.import("hyprland")
const { persistent } = options.bar.workspaces;

const dispatch = ws => hyprland.messageAsync(`dispatch workspace ${ws}`)

const Workspaces = (n: number) => Widget.Box({
  children: range(n || 10).map(i => Widget.Label({
    attribute: i,
    vpack: "center",
    label: `${i}`,
    setup: self => self.hook(hyprland, () => {
      self.toggleClassName("active", hyprland.active.workspace.id === i)
      self.toggleClassName("occupied", (hyprland.getWorkspace(i)?.windows || 0) > 0)
    })
  }))
})

export default () => PanelButton({
  window: "overview",
  class_name: "workspaces",
  on_scroll_up: () => dispatch("m+1"),
  on_scroll_down: () => dispatch("m-1"),
  on_clicked: () => App.toggleWindow("overview"),
  child: persistent.bind().as(Workspaces),
})
