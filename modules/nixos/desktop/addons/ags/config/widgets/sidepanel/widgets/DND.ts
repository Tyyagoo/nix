import icons from "lib/icons";
import { SimpleToggleButton } from "./ToggleButton"

const notifications = await Service.import("notifications")
const dnd = notifications.bind("dnd")

export const DND = () => SimpleToggleButton({
  icon: dnd.as(dnd => icons.notifications[dnd ? "silent" : "noisy"]),
  label: dnd.as(dnd => dnd ? "Silent" : "Noisy"),
  toggle: () => notifications.dnd = !notifications.dnd,
  connection: [notifications, () => notifications.dnd],
})

