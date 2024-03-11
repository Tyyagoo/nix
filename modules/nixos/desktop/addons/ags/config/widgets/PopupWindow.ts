import { type WindowProps } from "types/widgets/window"
import { type RevealerProps } from "types/widgets/revealer"
import { type EventBoxProps } from "types/widgets/eventbox"
import type Gtk from "gi://Gtk?version=3.0"
import options from "options"
import { type Widget as TWidget } from "types/@girs/gtk-3.0/gtk-3.0.cjs"

type Transition = RevealerProps["transition"]
type Child = WindowProps["child"]

type PopupWindowProps = Omit<WindowProps, "name"> & {
  name: string,
  layout?: keyof ReturnType<typeof Layout>,
  transition?: Transition,
}

export const Padding = (name: string, {
  css = "",
  hexpand = true,
  vexpand = true,
}: EventBoxProps = {}) => Widget.EventBox({
  hexpand,
  vexpand,
  can_focus: false,
  child: Widget.Box({ css }),
  setup: w => w.on("button-press-event", () => App.toggleWindow(name)),
})

const PopupRevealer = (name: string, child: Child, transition: Transition = "slide_down") => Widget.Box(
  { css: "padding: 1px;" },
  Widget.Revealer({
    transition,
    transitionDuration: options.transition.bind(),
    child: Widget.Box({
      class_name: "window-content",
      child,
    }),
    setup: self => self.hook(App, (_, wname, visible) => {
      if (wname === name) self.reveal_child = visible
    }),
  }),
)

// sorry...
type fn = (name: string) => (widget: Function, attrs: object, child: TWidget) => TWidget 
const center: fn = (name) => (widget, attrs, child) => widget(attrs, Padding(name), child, Padding(name))
const right: fn = (name) => (widget, attrs, child) => widget(attrs, Padding(name), child)
const left: fn = (name) => (widget, attrs, child) => widget(attrs, child, Padding(name))

const Layout = (name: string, child: Child, transition?: Transition) => {
  const pr = PopupRevealer(name, child, transition)
  const c = center(name)
  const r = right(name)
  const l = left(name)

  return {
    "center": () => c(Widget.CenterBox, {}, c(Widget.CenterBox, { vertical: true }, pr)),
    "top": () => c(Widget.CenterBox, {}, l(Widget.Box, { vertical: true }, pr)),
    "top-right": () => r(Widget.Box, {}, l(Widget.Box, { hexpand: false, vertical: true }, pr)),
    "top-center": () => c(Widget.Box, {}, l(Widget.Box, { hexpand: false, vertical: true }, pr)),
    "top-left": () => l(Widget.Box, {}, l(Widget.Box, { hexpand: false, vertical: true }, pr)),
    "bottom-left": () => l(Widget.Box, {}, r(Widget.Box, { hexpand: false, vertical: true }, pr)),
    "bottom-center": () => c(Widget.Box, {}, r(Widget.Box, { hexpand: false, vertical: true }, pr)),
    "bottom-right": () => r(Widget.Box, {}, r(Widget.Box, { hexpand: false, vertical: true }, pr)),
  }
}

export default ({
  name,
  child,
  layout = "center",
  transition,
  exclusivity = "ignore",
  ...props
}: PopupWindowProps) => Widget.Window<Gtk.Widget>({
    name,
    class_names: [name, "popup-window"],
    setup: w => w.keybind("Escape", () => App.closeWindow(name)),
    visible: false,
    keymode: "on-demand",
    exclusivity,
    anchor: ["top", "bottom", "right", "left"],
    child: Layout(name, child, transition)[layout](),
    ...props
  })
