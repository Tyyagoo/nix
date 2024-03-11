import icons from "lib/icons";
import options from "options";

const { wired } = await Service.import("network")
const internet = wired.bind("internet")

export const WiredIndicator = () => Widget.Box({
  class_names: internet.as(i => {
    return i === "connected" ? ["simple-toggle", "active"] : ["simple-toggle"]
  }),
  children: [
    Widget.Icon({
      icon: internet.as(i => icons.network[i]),
    }),
    Widget.Label({
      label: internet.as(i => `${i[0].toUpperCase()}${i.slice(1)}`),
    }),
  ],
}) 
