import { bash } from "lib/utils"

export default () => Widget.Button({
  label: "Change Wallpaper",
  on_clicked: () => {
    (async () => {
      const filename = await bash("find ~/nix/assets/wallpapers -type f | shuf -n 1")
      await bash(`cp -f ${filename} ~/.config/background`)
    })()
  },
})
