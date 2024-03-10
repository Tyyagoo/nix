import GLib from "gi://GLib";

const now = () => GLib.DateTime.new_now_local()
export const clock = Variable(now(), {
  poll: [1000, () => now()]
})

