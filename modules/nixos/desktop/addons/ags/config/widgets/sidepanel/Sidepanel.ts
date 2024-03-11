import options from "options";
import Gtk from "gi://Gtk?version=3.0";
import PopupWindow from "widgets/PopupWindow";
import Header from "./widgets/Header";
import Media from "./widgets/Media";
import { AppMixer, MicMute, Microphone, SinkSelector, Volume } from "./widgets/Volume";
import { DND } from "./widgets/DND";
import { DarkModeToggle } from "./widgets/DarkMode";
import { WiredIndicator } from "./widgets/Network";

const { bar, sidepanel } = options
const layout = Utils.derive([bar.position, sidepanel.position], (bar, sp) => `${bar}-${sp}` as const)
const media = await Service.import("mpris")

export function setupSidepanel() {
  App.addWindow(Sidepanel())
  layout.connect("changed", () => {
    App.removeWindow("sidepanel")
    App.addWindow(Sidepanel())
  })
}

type t = Array<() => Gtk.Widget>
const Row = (toggles: t = [], menus: t = []) => Widget.Box({
  vertical: true,
  children: [
    Widget.Box({
      homogeneous: true,
      class_name: "row horizontal",
      children: toggles.map(w => w()),
    }),
    ...menus.map(w => w()),
  ]
}) 

const Panel = () => Widget.Box({
  vertical: true,
  class_name: "sidepanel vertical",
  css: sidepanel.width.bind().as(w => `min-width: ${w}px;`),
  children: [
    Header(),
    Widget.Box({
      class_name: "sliders-box vertical",
      vertical: true,
      children: [
        Row([Volume], [SinkSelector, AppMixer]),
        Microphone(),
        // Brightness
      ],
    }),
    Row([WiredIndicator]),
    Row([DarkModeToggle], []),
    Row([MicMute], [DND]),
    Widget.Box({
      visible: media.bind("players").as(ps => ps.length > 0),
      child: Media(),
    })
  ]
})

const Sidepanel = () => PopupWindow({
  name: "sidepanel",
  exclusivity: "exclusive",
  transition: bar.position.bind().as(pos => pos === "top" ? "slide_down" : "slide_up"),
  layout: layout.value,
  child: Panel(),
})
