import GLib from "gi://GLib?version=2.0"
import icons, { substitutes } from "./icons"

/**
 * @returns [start...length]
 */
export const range = (length: number, start = 1) => Array.from({ length }, (_, i) => i + start) 

/**
 * @returns execAsync(["bash", "-c", cmd])
 */
export async function bash(strings: TemplateStringsArray | string, ...values: unknown[]) {
  const cmd = typeof strings === "string" ? strings : strings
    .flatMap((str, i) => str + `${values[i] ?? ""}`)
    .join("")

  return Utils.execAsync(["bash", "-c", cmd]).catch(err => {
    console.error(cmd, err)
    return ""
  })
}

/**
 * @returns execAsync(cmd)
 */
export async function sh(cmd: string | string[]) {
  return Utils.execAsync(cmd).catch(err => {
    console.error(typeof cmd === "string" ? cmd : cmd.join(" "), err)
    return ""
  })
}

/**
 * @returns true if all of the `bins` are found
 */
export function dependencies(...bins: string[]) {
  const missing = bins.filter(bin => !Utils.exec(`which ${bin}`))

  if (missing.length > 0) console.warn("missing dependencies:", missing.join(", "))
  return missing.length === 0
}

/**
 * @returns substitute icon || name || fallback icon
 */
export function icon(name: string | null, fallback = icons.missing) {
  if (!name) return fallback || ""
  if (GLib.file_test(name, GLib.FileTest.EXISTS)) return name

  const icon = (substitutes[name] || name)
  if (Utils.lookUpIcon(icon)) return icon

  print(`no icon substitute "${icon}" for "${name}", fallback: "${fallback}"`)
  return fallback
}
