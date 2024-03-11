import options from "options";
import PanelButton from "./PanelButton";

const { colored, icon, action } = options.bar.launcher;

export default () => PanelButton({
  window: "applications",
  onClicked: action.bind(),
  child: Widget.Box([
    Widget.Icon({
      class_name: colored.bind().as(c => c ? "colored" : ""),
      icon: icon.bind(),
    })
  ]) 
})
