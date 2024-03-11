import { MprisPlayer } from "types/service/mpris"

const mpris = await Service.import("mpris")
const players = mpris.bind("players")

const FALLBACK_ICON = "audio-x-generic-symbolic"
const PLAY_ICON = "media-playback-start-symbolic"
const PAUSE_ICON = "media-playback-pause-symbolic"
const PREV_ICON = "media-skip-backward-symbolic"
const NEXT_ICON = "media-skip-forward-symbolic"

function lengthStr(length: number) {
    if (length < 1) return "0:00"
    const min = Math.floor(length / 60)
    const sec = Math.floor(length % 60)
    const sec0 = sec < 10 ? "0" : ""
    return `${min}:${sec0}${sec}`
}

function Player(player: MprisPlayer) {
  const img = Widget.Box({
    class_name: "img",
    vpack: "start",
    css: player.bind("cover_path").as(p => `background-image: url('${p}');`),
  })

  const title = Widget.Label({
    class_name: "title",
    wrap: true,
    hpack: "start",
    label: player.bind("track_title"),
  })

  const artist = Widget.Label({
    class_name: "artist",
    wrap: true,
    hpack: "start",
    label: player.bind("track_artists").as(xs => xs.join(", ")),
  }) 

  const positionSlider = Widget.Slider({
    class_name: "position",
    drawValue: false,
    on_change: ({ value }) => player.position = value * player.length,
    setup: self => {
      const update = () => {
        self.visible = player.length > 0
        self.value = player.position / player.length
      }

      self.hook(player, update)
      self.hook(player, update, "position")
      self.poll(1000, update)
    }
  })

  const positionLabel = Widget.Label({
    class_name: "position",
    hpack: "start",
    setup: self => {
      const update = (_: unknown, time?: number) => {
        self.label = lengthStr(time || player.position)
        self.visible = player.length > 0
      }

      self.hook(player, update, "position")
      self.poll(1000, update)
    }
  })

  const lengthLabel = Widget.Label({
    class_name: "length",
    hpack: "end",
    visible: player.bind("length").as(l => l > 0),
    label: player.bind("length").as(lengthStr),
  })

  const icon = Widget.Icon({
    class_name: "icon",
    hexpand: true,
    hpack: "end",
    vpack: "start",
    tooltip_text: player.identity || "",
    icon: player.bind("entry").as(e => {
      const name = `${e}-symbolic`
      return Utils.lookUpIcon(name) ? name : FALLBACK_ICON
    })
  })

  const toggle = Widget.Button({
    class_name: "toggle",
    on_clicked: () => player.playPause(),
    visible: player.bind("can_play"),
    child: Widget.Icon({
      icon: player.bind("play_back_status").as(s => {
        if (s === "Playing") return PAUSE_ICON
        if (s === "Paused") return PLAY_ICON
        return ""
      })
    })
  })

  const prev = Widget.Button({
    class_name: "prev",
    on_clicked: () => player.previous(),
    visible: player.bind("can_go_prev"),
    child: Widget.Icon(PREV_ICON),
  })

  const next = Widget.Button({
    class_name: "next",
    on_clicked: () => player.next(),
    visible: player.bind("can_go_next"),
    child: Widget.Icon(NEXT_ICON),
  })

  return Widget.Box({
    class_name: "player",
    children: [
      img,
      Widget.Box({
        vertical: true,
        hexpand: true,
        children: [
          Widget.Box({
            children: [title, icon],
          }),
          artist,
          Widget.Box({ vexpand:true }),
          positionSlider,
          Widget.CenterBox({
            start_widget: positionLabel,
            center_widget: Widget.Box([prev, toggle, next]),
            end_widget: lengthLabel,
          })
        ],
      })
    ],
  })
}

export default () => Widget.Box({
  vertical: true,
  css: "min-height: 2px; min-width: 2px;",
  visible: players.as(p => p.length > 0),
  children: players.as(p => p.filter(x => x.name === "mpd").map(Player)),
})
