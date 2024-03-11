import { MprisPlayer } from "types/service/mpris"
import options from "options"
import icons from "lib/icons"
import { icon } from "lib/utils"

const mpris = await Service.import("mpris")
const players = mpris.bind("players")
const { media } = options.sidepanel

function lengthStr(length: number) {
    if (length < 1) return "0:00"
    const min = Math.floor(length / 60)
    const sec = Math.floor(length % 60)
    const sec0 = sec < 10 ? "0" : ""
    return `${min}:${sec0}${sec}`
}

function Player(player: MprisPlayer) {
  const img = Widget.Box({
    class_name: "cover",
    vpack: "start",
    css: Utils.merge([
      player.bind("cover_path"),
      player.bind("track_cover_url"),
      media.coverSize.bind(),
    ], (path, url, size) => `
        min-width: ${size}px;
        min-height: ${size}px;
        background-image: url('${path || url}');
    `),
  })

  const title = Widget.Label({
    class_name: "title",
    max_width_chars: 20,
    truncate: "end",
    hpack: "start",
    label: player.bind("track_title"),
  })

  const artist = Widget.Label({
    class_name: "artist",
    max_width_chars: 20,
    truncate: "end",
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

  const playerIcon = Widget.Icon({
    class_name: "icon",
    hexpand: true,
    hpack: "end",
    vpack: "start",
    tooltip_text: player.identity || "",
    icon: Utils.merge([player.bind("entry"), media.monochromeIcon.bind()], (e, c) => icon(`${e}${c ? "-symbolic" : ""}`)),
  })

  const toggle = Widget.Button({
    class_name: "play-pause",
    on_clicked: () => player.playPause(),
    visible: player.bind("can_play"),
    child: Widget.Icon({
      icon: player.bind("play_back_status").as(s => {
        if (s === "Playing") return icons.media.playing
        return icons.media.stopped
      })
    })
  })

  const prev = Widget.Button({
    class_name: "prev",
    on_clicked: () => player.previous(),
    visible: player.bind("can_go_prev"),
    child: Widget.Icon(icons.media.prev),
  })

  const next = Widget.Button({
    class_name: "next",
    on_clicked: () => player.next(),
    visible: player.bind("can_go_next"),
    child: Widget.Icon(icons.media.next),
  })

  return Widget.Box({
    class_name: "player",
    vexpand: false,
    children: [
      img,
      Widget.Box({
        vertical: true,
        hexpand: true,
        children: [
          Widget.Box({
            children: [title, playerIcon],
          }),
          artist,
          Widget.Box({ vexpand:true }),
          positionSlider,
          Widget.CenterBox({
            class_name: "footer horizontal",
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
  class_name: "media vertical",
  children: players.as(p => p.map(Player)),
})
