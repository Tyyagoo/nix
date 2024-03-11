import Media from "./widgets/Media";

export default () => Widget.Window({
  name: "sidepanel",
  setup: w => w.keybind("Escape", () => App.closeWindow("sidepanel")),
  visible: false,
  keymode: "on-demand",
  layer: "top",
  anchor: ["top", "right"],
  child: Widget.Box({
    children: [ Widget.Label("menu"), Media() ],
  }) 
})
