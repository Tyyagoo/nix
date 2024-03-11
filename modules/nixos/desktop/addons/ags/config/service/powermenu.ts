import options from "options";

const { logout, reboot, shutdown } = options.powermenu

export type Action = "logout" | "reboot" | "shutdown"

class PowerMenu extends Service {
  static {
    Service.register(this, {}, {
      "title": ["string"],
      "cmd": ["string"],
    })
  }

  #title = ""
  #cmd = ""

  action(action: Action) {
    [this.#cmd, this.#title] = {
      logout: [logout.value, "Log Out"],
      reboot: [reboot.value, "Reboot"],
      shutdown: [shutdown.value, "Shutdown"],
    }[action]

    this.notify("cmd")
    this.notify("title")
    this.emit("changed")
    App.closeWindow("powermenu")
    App.openWindow("verification")
  }

  readonly shutdown = () => {
    this.action("shutdown")
  }

  get title() { return this.#title }
  get cmd() { return this.#cmd }
}

const powermenu = new PowerMenu
globalThis["powermenu"] = powermenu
export default powermenu
