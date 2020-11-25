import React, { useEffect, useState } from "react";
import _ from "lodash";
import Filter from "../lib/helpers/filter";
import Row from "../components/Row";
import Col from "../components/Col";
import Chat from "./Shared/Chat";
import Editor from "./Shared/Editor";
import Output from "./Shared/Output";
import Constants from "../lib/constants/constants";
import ConfettiGenerator from "confetti-js";
import Votes from "./Shared/Votes";
import { Store, notLoaded, State } from "../store";
import { Game } from "../Game";
import { Channel } from "phoenix";

interface Props {
  game: Game;
  store: Store;
}

const GameView = ({ game, store }: Props): JSX.Element => {
  const [addition, setAddition] = useState("");
  const [error, setError] = useState("");
  const [confetti, setConfetti] = useState(false);

  useEffect(() => {
    setConfetti(_.get(game, "settings.confetti"));
  }, [game]);

  useEffect(() => {
    if (!confetti) return;
    const confettiSettings = {
      target: "my-canvas",
      max: 300,
      size: 0.8,
    };
    const _confetti = ConfettiGenerator(confettiSettings);
    _confetti.render();

    return () => _confetti.clear();
  }, [confetti]);

  const _handleInput = (e) => {
    if (
      e.target.value.length <= game.max_input ||
      e.target.value.substr(0, 1) === Constants.CODE_KEY ||
      Object.values(Constants.COMMANDS).join("").includes(e.target.value)
    ) {
      setError("");
    } else {
      setError("Too many characters");
    }

    const value = e.target.value.replace(/['`]/, '"');

    setAddition(value);
  };

  const _handleEnter = (e) => {
    if (e.key === Constants.ENTER) {
      _handleSubmit(addition);
    }
  };

  const _handleInvisibilityToggle = (on: boolean): void => {
    store.update("toggle-invisibility", on);
  };

  const _handleSubmit = (val): void => {
    if (val === "") return;

    if (
      Object.values(Constants.COMMANDS).includes(val) == false &&
      val[0] !== Constants.CODE_KEY
    ) {
      if (val.length > game.max_input) {
        setError("This message is too long");
        return;
      }
      if (new Filter().isProfane(val)) {
        setError("Message includes inappropriate language");
        return;
      }
    } else {
      if (new Filter().isProfane(val.substring(1))) {
        setError("Message includes inappropriate language");
        return;
      }
    }

    type Data = {
      isCode: boolean;
      addition: string;
    };

    const messagePayload: Data = {
      isCode: true,
      addition: val,
    };

    if (val[0] === Constants.CODE_KEY) {
      messagePayload.isCode = false;
      messagePayload.addition = val.substring(1);
    }

    (store.get("socket") as Channel).push("message:new", messagePayload);
    setAddition("");
    document.getElementById("chatFieldInput").focus();
  };

  return (
    <>
      <canvas
        className={game.confetti ? "confetti-on" : "confetti-off"}
        id="my-canvas"
      ></canvas>
      {game.play_state === "paused" && (
        <>
          <div className="paused"></div>
        </>
      )}
      <Row className="header">
        <h1>{game.name}</h1>
      </Row>
      <Row className="game-container">
        <Col className="output-content section column">
          <Editor game={game} output={game.output} showInvisibles={true} />
          <Output output={game.output} />
        </Col>
        {game.mode.toLowerCase() !== Constants.ANARCHY && true}
        <Votes
          _handleSubmit={_handleSubmit}
          game={game}
          canVote={game.can_vote}
        />
        <Col className="chat-sidebar">
          <Chat
            _handleSubmit={_handleSubmit}
            _handleInput={_handleInput}
            _handleEnter={_handleEnter}
            _handleInvisibilityToggle={_handleInvisibilityToggle}
            game={game}
            addition={addition}
            error={error}
            userToken={"temp-token"}
            showInvisibles={true}
            userCount={1}
            messages={[]}
          />
        </Col>
      </Row>
    </>
  );
};

export default GameView;
