DROP TABLE players;
DROP TABLE games;

CREATE TABLE players(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  nickname VARCHAR(255),
  dominant_hand VARCHAR(255),
  skill_set VARCHAR(255),
  win_count INT4,
  loss_count INT4
);

CREATE TABLE games(
  id SERIAL4 PRIMARY KEY,
  game_date DATE,
  game_time TIME
);