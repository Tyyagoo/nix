import { MprisPlayer } from "types/service/mpris"
import PanelButton from "./PanelButton"
import icons from "lib/icons"

const mpris = await Service.import("mpris")

const formatter: Record<string, (_: string) => string> = {
  "Enygma": (title) => title.split(" |")[0],
  "M4rkim": (title) => title.split("- ")[1].split(" |")[0],
  "Novatroop": (title) => title.split(" |")[0],
  "Rodrigo Zin": (title) => title.split("- ")[1].split(" (")[0],
  "Kaito": (title) => title.split("| ")[1].split(" |")[0],
  "Henrique Mendonça": (title) => title.split('"')[1].split('"')[0],
}

function format_title(title: string, artists: string | string[]) {
  if (Array.isArray(artists)) artists = artists[0]
  return (formatter[artists] ?? ((t) => t))(title)
}

function Player(player: MprisPlayer) {
  const Title = Widget.Label({
    class_name: "title",
    max_width_chars: 20,
    truncate: "end",
    hpack: "start",
    label: Utils.merge([player.bind("track_title"), player.bind("track_artists")], format_title) 
  })

  const Separator = Widget.Label({
    label: " | ",
  })

  const Artist = Widget.Label({
    class_name: "artist",
    max_width_chars: 20,
    truncate: "end",
    hpack: "start",
    label: player.bind("track_artists").as(xs => xs.join(", ")),
  })

  return Widget.Box({
    children: [
      Title,
      Separator,
      Artist,
    ],
  })
}

export default () => PanelButton({
  window: "music-player",
  onClicked: () => { },
  visible: mpris.bind("players").as(p => p.length > 0),
  child: mpris.bind("players").as(p => Player(p[0])),
})
