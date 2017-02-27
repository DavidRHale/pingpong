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

tournament1 = Tournament.new({'name' => 'Master League', 'format' => 'league'})
tournament2 = Tournament.new({'name' => 'Master Cup', 'format' => 'knock-out'})
tournament3 = Tournament.new({'name' => 'Friendlies', 'format' => 'league'})

tournament1.save
tournament2.save
tournament3.save


game1 = Game.new({'game_date' => '2017/02/23', 'game_time' => '16:00', 'tournament_id' => tournament3.id})
game2 = Game.new({'game_date' => '2017/02/25', 'game_time' => '15:00', 'tournament_id' => tournament3.id})
game3 = Game.new({'game_date' => '2017/02/25', 'game_time' => '15:00', 'tournament_id' => tournament1.id})
game4 = Game.new({'game_date' => '2017/02/25', 'game_time' => '15:00', 'tournament_id' => tournament1.id})

game1.save
game2.save
game3.save
game4.save

tournament_player1 = TournamentPlayer.new({'player_id' => player1.id, 'tournament_id' => tournament1.id})
tournament_player2 = TournamentPlayer.new({'player_id' => player2.id, 'tournament_id' => tournament1.id})

tournament_player1.save
tournament_player2.save

player_game1 = PlayerGame.new({'player_id' => player1.id, 'game_id' => game1.id, 'player_score' => 21, 'player_won' => true})
player_game2 = PlayerGame.new({'player_id' => player2.id, 'game_id' => game1.id, 'player_score' => 15, 'player_won' => false})
player_game3 = PlayerGame.new({'player_id' => player1.id, 'game_id' => game2.id, 'player_score' => 15, 'player_won' => false})
player_game4 = PlayerGame.new({'player_id' => player2.id, 'game_id' => game2.id, 'player_score' => 21, 'player_won' => true})
player_game5 = PlayerGame.new({'player_id' => player2.id, 'game_id' => game3.id, 'player_score' => 21, 'player_won' => true})
player_game6 = PlayerGame.new({'player_id' => player3.id, 'game_id' => game3.id, 'player_score' => 10, 'player_won' => false})
player_game7 = PlayerGame.new({'player_id' => player3.id, 'game_id' => game4.id, 'player_score' => 21, 'player_won' => true})
player_game8 = PlayerGame.new({'player_id' => player4.id, 'game_id' => game4.id, 'player_score' => 12, 'player_won' => false})


player_game1.save
player_game2.save
player_game3.save
player_game4.save
player_game5.save
player_game6.save
player_game7.save
player_game8.save


binding.pry
nil