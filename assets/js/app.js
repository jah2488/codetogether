// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"

import React from "react";
import ReactDOM from "react-dom";
import Game from './views/Game'

const app = document.getElementById("app");

const pathName = window.location.pathname.split("/")
const path = pathName[1]
const id = pathName[2]

switch (path) {
  case "games":
    if (!id) break;
    ReactDOM.render(<Game id={id} />, app);
    break;
}
