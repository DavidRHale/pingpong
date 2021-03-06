DROP TABLE player_games;
DROP TABLE tournament_players;
DROP TABLE games;
DROP TABLE tournaments;
DROP TABLE players;



CREATE TABLE players(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  nickname VARCHAR(255),
  dominant_hand VARCHAR(255),
  skill_set VARCHAR(255),
  win_count INT4,
  loss_count INT4
);

CREATE TABLE tournaments (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  format VARCHAR(255)
);

CREATE TABLE games(
  id SERIAL4 PRIMARY KEY,
  tournament_id INT4 REFERENCES tournaments(id) ON DELETE CASCADE,
  tournament_round INT4,
  game_date DATE
);

CREATE TABLE tournament_players(
  id SERIAL4 PRIMARY KEY,
  player_id INT4 REFERENCES players(id) ON DELETE CASCADE,
  tournament_id INT4 REFERENCES tournaments(id) ON DELETE CASCADE
);

CREATE TABLE player_games(
  id SERIAL4 PRIMARY KEY,
  player_id INT4 REFERENCES players(id) ON DELETE CASCADE,
  game_id INT4 REFERENCES games(id) ON DELETE CASCADE,
  tournament_id INT4 REFERENCES tournaments(id) ON DELETE CASCADE,
  player_score INT4,
  player_won BOOLEAN
);