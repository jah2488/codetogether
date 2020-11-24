import Game from "./views/Game";
import React from "react";

const App = ({ id }) => {
  console.log(id);
  return <Game id={id} />;
};

export default App;
