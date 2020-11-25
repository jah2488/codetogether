import { Game } from "./Game";

type NotLoaded = { status: "not-loaded" };
type Loading = { status: "loading" };
type Loaded<t> = { status: "loaded"; record: t };
type Error<e> = { status: "error"; error: e };
type RemoteData<t, e> = NotLoaded | Loading | Loaded<t> | Error<e>;

const notLoaded: NotLoaded = { status: "not-loaded" };

function loaded<T>(record: T): Loaded<T> {
  return {
    status: "loaded",
    record: record,
  };
}

type State = {
  game: RemoteData<Game, string>;
  settings: {
    showInvisibles: boolean;
  };
};

type StoreEvent =
  | "noop"
  | "game-loaded"
  | "toggle-invisibility"
  | "message-input"
  | "message-submit"
  | "messages-loaded";

class Store {
  state: State;
  storage: { [key: string]: any };
  subscribers: ((fn: State) => void)[];

  constructor(initialState: State) {
    this.state = { ...initialState };
    this.storage = {};
    this.subscribers = [];
  }

  add(name: string, val: any): Store {
    if (this.storage[name]) {
      console.warn("You have added a new value with the same name to storage");
    }
    this.storage[name] = val;
    return this;
  }

  get(name: string): any {
    console.debug(`Retreiving ${name} from storage.`);
    return this.storage[name];
  }

  watch(fn: (fn: State) => void): Store {
    this.subscribers.push(fn);
    return this;
  }

  update(event: StoreEvent, payload: any): Store {
    console.debug(`Update: '${event}':`);
    console.dir(payload);
    console.debug(`Before:`);
    console.dir(this.state);
    switch (event) {
      case "game-loaded":
        this.state = { ...this.state, game: loaded({ ...payload }) };
        break;
      case "toggle-invisibility":
        this.state = {
          ...this.state,
          settings: { ...this.state.settings, showInvisibles: payload },
        };

      default:
        break;
    }
    console.debug(`After:`);
    console.dir(this.state);
    this.notify();
    return this;
  }

  private notify(): void {
    console.debug(`Notifying(${this.subscribers.length}) about state update`);
    this.subscribers.forEach((fn) => {
      fn(this.state);
    });
  }
}

export type { State, StoreEvent, RemoteData };
export { Store, notLoaded };
