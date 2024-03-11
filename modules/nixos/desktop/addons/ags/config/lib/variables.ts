import GLib from "gi://GLib";

const now = () => GLib.DateTime.new_now_local()
export const clock = Variable(now(), {
  poll: [1000, () => now()]
})

export const distro = GLib.get_os_info("ID")

export const uptime = Variable(0, {
  poll: [60_000, "cat /proc/uptime", line => Number.parseInt(line.split(".")[0]) / 60]
})
