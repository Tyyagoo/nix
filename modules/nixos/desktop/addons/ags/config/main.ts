import Bar from "widgets/bar/Bar"

Utils.monitorFile("./style.css", () => {
  App.resetCss()
  App.applyCss("./style.css")
})

App.config({
  style: "./style.css",
  windows: [Bar()]
})
