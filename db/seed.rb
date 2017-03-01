require('pry')
require_relative('../models/player.rb')
require_relative('../models/game.rb')
require_relative('../models/player_game.rb')
require_relative('../models/tournament.rb')
require_relative('../models/tournament_player.rb')

Player.delete_all
Game.delete_all
Tournament.delete_all
TournamentPlayer.delete_all
PlayerGame.delete_all

player1 = Player.new({
  'name' => 'David Hale',
  'nickname' => 'The Admiral',
  'dominant_hand' => 'Right',
  'skill_set' => 'Backhand God',
  'win_count' => 0,
  'loss_count' => 0
  })

player2 = Player.new({
  'name' => 'Lorna Hale',
  'nickname' => 'The Wimp',
  'dominant_hand' => 'Right',
  'skill_set' => 'None',
  'win_count' => 0,
  'loss_count' => 0
  })

player3 = Player.new({
  'name' => 'Winston Hale',
  'nickname' => 'The Cat',
  'dominant_hand' => 'Right',
  'skill_set' => 'None',
  'win_count' => 0,
  'loss_count' => 0
  })

player4 = Player.new({
  'name' => 'Jimmy',
  'nickname' => 'Jim',
  'dominant_hand' => 'Right',
  'skill_set' => 'None',
  'win_count' => 0,
  'loss_count' => 0
  })

player1.save
player2.save
player3.save
player4.save

tournament1 = Tournament.new({'name' => 'Master League', 'format' => 'League'})
tournament2 = Tournament.new({'name' => 'Master Cup', 'format' => 'Knock-Out'})
tournament3 = Tournament.new({'name' => 'Friendlies', 'format' => 'Friendly'})

tournament1.save
tournament2.save
tournament3.save

# player_game1 = PlayerGame.new({'player_id' => player1.id, 'game_id' => game1.id, 'player_score' => 21, 'tournament_id' => tournament2.id, 'player_won' => false})



binding.pry
nil