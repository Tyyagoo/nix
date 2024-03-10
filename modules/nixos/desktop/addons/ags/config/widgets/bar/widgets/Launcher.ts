import options from "options";
import PanelButton from "./PanelButton";
import Gtk from "gi://Gtk?version=3.0";

const { colored, icon, action } = options.bar.launcher;

export default () => PanelButton({
  window: "applications",
  onClicked: action.bind(),
  child: Widget.Label({
    label: icon.bind(),
    halign: Gtk.Align.CENTER,
    class_name: colored.bind().as(c => c ? "colored" : ""),
  }) 
})
