import options from "options"
import { dependencies, sh } from "./utils"

const path = `/home/${Utils.USER}/.config/background`

async function wallpaper() {
  const pos = await sh("hyprctl cursorpos")

  await sh([
    "swww", "img",
    "--transition-step", "100",
    "--transition-duration", "1.5",
    "--transition-fps", "144",
    "--transition-type", "grow",
    "--transition-pos", pos.replace(" ", ""),
    options.wallpaper.value,
  ])
}

export default async function init() {
  if (!dependencies("swww")) return

  Utils.monitorFile(path, () => options.wallpaper.setValue(path))
  options.wallpaper.connect("changed", wallpaper)

  Utils.execAsync("swww init").catch(() => { })
  wallpaper()
}
