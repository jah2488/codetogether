// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.css";

import { Socket } from "phoenix";
import socket from "./socket";

import "phoenix_html";

import * as React from "react";
import * as ReactDOM from "react-dom";
import App from "./App";

const pathName = window.location.pathname.split("/");
const id = pathName[2];

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(<App id={id} />, document.getElementById("app"));
});
