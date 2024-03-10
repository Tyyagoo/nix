import Bar from "widgets/bar/Bar"
import Sidepanel from "widgets/sidepanel/Sidepanel"

Utils.monitorFile("./style.css", () => {
  App.resetCss()
  App.applyCss("./style.css")
})

App.config({
  style: "./style.css",
  windows: [Bar(), Sidepanel()],
})
