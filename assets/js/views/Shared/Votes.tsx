import Button from "../../components/Button";
import React from "react";

const Votes = ({ game, _handleSubmit, canVote = true }) => {
  return (
    <div className="vote-section">
      <ul className="vote-list">
        <h4>Choices</h4>
        <div className="info">{game.vote_threshold} Votes Needed</div>
        {(game.nominees || [])
          .filter((nominee) => nominee.votes_count > 1)
          .map((nominee) => (
            <li
              key={nominee.id}
              className="vote-item"
              onClick={() => canVote && _handleSubmit(nominee.body)}
            >
              <div
                className={
                  "badge full-width " +
                  (canVote ? "vote clickable" : "disabled")
                }
              >
                <span>{nominee.votes_count} Votes</span>
                <pre>{nominee.body}</pre>
              </div>
            </li>
          ))}
      </ul>
    </div>
  );
};
export default Votes;
