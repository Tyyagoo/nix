import { Variable } from "resource:///com/github/Aylur/ags/variable.js";

type OptProps = {
  persistent?: boolean
}

class Opt<T = unknown> extends Variable<T> {
  static { Service.register(this) }

  readonly #initial: T;
  #persistent: boolean;

  constructor(initial: T, props: OptProps) {
    super(initial);
    this.#initial = initial;
    this.#persistent = props.persistent ?? false;
  }

  reset() {
    if (this.#persistent) return;
    this.value = this.#initial;
  }
}

export const mkOpt = <T>(initial: T, opts?: OptProps) => new Opt(initial, opts ?? {})
