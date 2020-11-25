import Button from "../../components/Button";
import Reference from "../../components/Reference";
import React from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faCode,
  faEye,
  faEyeSlash,
  faKeyboard,
  faUserPlus,
  faUsers,
  faVoteYea,
} from "@fortawesome/free-solid-svg-icons";
import Constants from "../../lib/constants/constants";
import { Game } from "../../Game";

interface Message {
  body: string;
  color: string;
  id: number;
  is_code: boolean;
  token: string;
}
interface Props {
  _handleEnter: (val: any) => void;
  _handleInput: (val: any) => void;
  _handleInvisibilityToggle: (val: boolean) => void;
  _handleSubmit: (val: any) => void;
  addition: string;
  error: string;
  game: Game;
  messages: Message[];
  showInvisibles: boolean;
  userCount: number;
  userToken: string;
}
const Chat = ({
  _handleEnter,
  _handleInput,
  _handleInvisibilityToggle,
  _handleSubmit,
  addition,
  error,
  game,
  messages = [],
  showInvisibles,
  userCount,
  userToken,
}: Props) => {
  const isMessage = addition.substr(0, 1) === Constants.CODE_KEY;
  const remainingCharacters = Math.min(
    Math.max(game.max_input - addition.length, 0),
    game.max_input
  );

  return (
    <div className="chat">
      <div className={"chat__toolbar " + game.mode.toLowerCase()}>
        <span className="clickable">
          {showInvisibles ? (
            <FontAwesomeIcon
              size="sm"
              border
              icon={faEye}
              onClick={() => _handleInvisibilityToggle(false)}
            />
          ) : (
            <FontAwesomeIcon
              size="sm"
              border
              icon={faEyeSlash}
              onClick={() => _handleInvisibilityToggle(true)}
            />
          )}
        </span>
        <span>
          {game.mode.toLowerCase() === Constants.ANARCHY ? (
            <>
              <span> ANARCHY</span>
              <FontAwesomeIcon size="sm" icon={faUserPlus} />
            </>
          ) : (
            <>
              <span> DEMOCRACY</span>
              <FontAwesomeIcon size="sm" icon={faVoteYea} />
            </>
          )}
        </span>
        <span>
          <span>{game.max_input}</span>
          <FontAwesomeIcon size="sm" icon={faKeyboard} />
        </span>
        <span>
          <span>{userCount}</span> <FontAwesomeIcon size="sm" icon={faUsers} />
        </span>
      </div>
      <div className="chat__section--column-reverse">
        <div className="chat__section--output">
          {messages.map((message) => {
            const currentUserStyle =
              userToken === message.token
                ? "chat__output--current-user"
                : "chat__output--other-user";

            if (message.is_code) {
              return (
                <div
                  key={message.id}
                  style={{ backgroundColor: message.color }}
                  className={`chat__output chat__output--code ${currentUserStyle}`}
                >
                  <FontAwesomeIcon size="xs" icon={faCode} />
                  <span className="chat__output--text">{message.body}</span>
                </div>
              );
            } else {
              return (
                <div
                  key={message.id}
                  style={{ backgroundColor: message.color }}
                  className={`chat__output ${currentUserStyle}`}
                >
                  <span className="chat__output--text">{message.body}</span>
                </div>
              );
            }
          })}
        </div>
      </div>
      <div className="chat__section--input">
        <small>{error}</small>
        <div className="chat__field--input-wrapper">
          <span className={error ? " with-error" : ""}>
            {!isMessage ? remainingCharacters : "∞"}
          </span>
          <input
            className={"chat__field--input " + (error ? " with-error" : "")}
            id="chatFieldInput"
            onInput={(e) => _handleInput(e)}
            onKeyDown={(e) => _handleEnter(e)}
            onChange={() => {}}
            placeholder="Start Coding..."
            value={`${addition}`}
            autoFocus
            autoComplete="off"
          />
          <Button
            className="button chat__field--submit mb-space-sm"
            handleClick={() => _handleSubmit(addition)}
            name="Send"
          />
        </div>
        <div className="chat__field--submit-wrapper">
          <Reference _handleSubmit={_handleSubmit} />
        </div>
      </div>
    </div>
  );
};

export default Chat;
