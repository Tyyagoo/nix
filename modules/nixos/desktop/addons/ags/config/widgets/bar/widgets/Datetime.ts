import options from "options"
import { clock } from "lib/variables";
import PanelButton from "./PanelButton";

const { format, action } = options.bar.datetime;
const time = Utils.derive([clock, format], (c, f) => c.format(f) || "")

export default () => PanelButton({
  window: "calendar",
  onClicked: action.bind(),
  child: Widget.Label({
    label: time.bind(),
  })
})
