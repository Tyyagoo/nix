import options from "options";
import PanelButton from "./PanelButton";

const { icon, action } = options.bar.sidepanel;

export default () => PanelButton({
  window: "sidepanel",
  on_clicked: action.bind(),
  child: Widget.Label({
    label: icon.bind(),
  }) 
})
