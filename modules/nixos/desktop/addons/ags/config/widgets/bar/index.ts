import DateTime from "widgets/datetime/index";

export default function Bar(monitor = 0) {
  return Widget.Window({
    monitor,
    name: `bar-${monitor}`,
    anchor: ["top", "right", "left"],
    child: DateTime(),
  })
}
