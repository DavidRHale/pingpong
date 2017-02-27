require('pry')
require_relative('../models/player.rb')
require_relative('../models/game.rb')
require_relative('../models/player_game.rb')
require_relative('../models/tournament.rb')

Player.delete_all
Game.delete_all
Tournament.delete_all
PlayerGame.delete_all

player1 = Player.new({
  'name' => 'David Hale',
  'nickname' => 'The Admiral',
  'dominant_hand' => 'Right',
  'skill_set' => 'Backhand God',
  'win_count' => 4,
  'loss_count' => 0
  })

player2 = Player.new({
  'name' => 'Lorna Hale',
  'nickname' => 'The Wimp',
  'dominant_hand' => 'Right',
  'skill_set' => 'None',
  'win_count' => 1,
  'loss_count' => 0
  })

player3 = Player.new({
  'name' => 'Winston Hale',
  'nickname' => 'The Cat',
  'dominant_hand' => 'Right',
  'skill_set' => 'None',
  'win_count' => 5,
  'loss_count' => 0
  })

player4 = Player.new({
  'name' => 'Jimmy',
  'nickname' => 'Jim',
  'dominant_hand' => 'Right',
  'skill_set' => 'None',
  'win_count' => 3,
  'loss_count' => 0
  })

player1.save
player2.save
player3.save
player4.save

game1 = Game.new({'game_date' => '2017/02/23', 'game_time' => '16:00'})
game2 = Game.new({'game_date' => '2017/02/25', 'game_time' => '15:00'})

game1.save
game2.save

tournament1 = Tournament.new({'name' => 'Master League', 'format' => 'league'})
tournament2 = Tournament.new({'name' => 'Master Cup', 'format' => 'knock-out'})

tournament1.save
tournament2.save

player_game1 = PlayerGame.new({'player_id' => player1.id, 'game_id' => game1.id, 'player_score' => 21, 'player_won' => true})
player_game2 = PlayerGame.new({'player_id' => player2.id, 'game_id' => game1.id, 'player_score' => 15, 'player_won' => false})
player_game3 = PlayerGame.new({'player_id' => player1.id, 'game_id' => game2.id, 'player_score' => 15, 'player_won' => false})
player_game4 = PlayerGame.new({'player_id' => player2.id, 'game_id' => game2.id, 'player_score' => 21, 'player_won' => true})

player_game1.save
player_game2.save
player_game3.save
player_game4.save


binding.pry
nil