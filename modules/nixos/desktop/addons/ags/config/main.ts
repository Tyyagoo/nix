import "lib/session"
import "lib/init"
import options from "options"
import Bar from "widgets/bar/Bar"
import Sidepanel from "widgets/sidepanel/Sidepanel"
import { init } from "lib/init"

App.config({
  onConfigParsed: () => {
    init()
  },
  windows: [Bar(), Sidepanel()],
})
