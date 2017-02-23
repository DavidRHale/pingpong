DROP TABLE players;
DROP TABLE game;

CREATE TABLE players(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  nickname VARCHAR(255),
  dominant_hand VARCHAR(255),
  skill_set VARCHAR(255),
  win_count INT4,
  loss_count INT4
);

CREATE TABLE game(
  id SERIAL4 PRIMARY KEY,
  game_date DATE
);