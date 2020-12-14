import React, { useEffect, useState } from "react";
import GameView from "./views/Game";
import socket from "./socket";
import { Store, notLoaded, State } from "./store";
import { Channel } from "phoenix";

const initialState: State = {
  game: notLoaded,
  settings: { showInvisibles: false },
};
const store = new Store(initialState);

const App = ({ id }): JSX.Element => {
  let channel: Channel;
  let [state, updateState] = useState(initialState as State);

  useEffect((): void => {
    channel = socket.channel(`game:${id}`, {});
    channel
      .join()
      .receive("ok", () => console.debug("connected"))
      .receive("error", () =>
        console.error("Unable to connect to game channel")
      );
    channel.on("game:loaded", (resp) => {
      store.update("game-loaded", resp);
    });

    store.add("socket", channel);
    store.watch(updateState);
  }, ["run-once"]);

  switch (state.game.status) {
    case "not-loaded":
      return <h1 className="loading spinner"> Loading </h1>;

    case "loaded":
      return (
        <>
          <GameView game={state.game.record} store={store} />
        </>
      );
  }
};

export default App;
