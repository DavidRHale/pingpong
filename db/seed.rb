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
  'name' => 'Bruce Banner',
  'nickname' => 'The Incredible Hulk',
  'dominant_hand' => 'Right',
  'skill_set' => 'Smash',
  'win_count' => 0,
  'loss_count' => 0
  })

player2 = Player.new({
  'name' => 'Tony Stark',
  'nickname' => 'Iron Man',
  'dominant_hand' => 'Right',
  'skill_set' => 'Flying Forehand',
  'win_count' => 0,
  'loss_count' => 0
  })

player3 = Player.new({
  'name' => 'Thor Odinson',
  'nickname' => 'Thor',
  'dominant_hand' => 'Right',
  'skill_set' => 'Lightning shots',
  'win_count' => 0,
  'loss_count' => 0
  })

player4 = Player.new({
  'name' => 'Steve Rogers',
  'nickname' => 'Captain America',
  'dominant_hand' => 'Right',
  'skill_set' => 'Block',
  'win_count' => 0,
  'loss_count' => 0
  })

player5 = Player.new({
  'name' => 'Scott Lang',
  'nickname' => 'Ant-Man',
  'dominant_hand' => 'Right',
  'skill_set' => 'Drop shot',
  'win_count' => 0,
  'loss_count' => 0
  })

player6 = Player.new({
  'name' => 'Peter Parker',
  'nickname' => 'Spider-Man',
  'dominant_hand' => 'Right',
  'skill_set' => 'None',
  'win_count' => 0,
  'loss_count' => 0
  })

player1.save
player2.save
player3.save
player4.save
player5.save
player6.save

tournament1 = Tournament.new({'name' => 'Master League', 'format' => 'League'})
tournament2 = Tournament.new({'name' => 'Master Cup', 'format' => 'Knock-Out'})
tournament3 = Tournament.new({'name' => 'Friendlies', 'format' => 'Friendly'})

tournament1.save
tournament2.save
tournament3.save

tournament1.add_player(player1.id)
tournament1.add_player(player2.id)
tournament1.add_player(player3.id)
tournament1.add_player(player4.id)
tournament1.add_player(player5.id)
tournament1.add_player(player6.id)

tournament1.create_league_fixtures

tournament2.add_player(player1.id)
tournament2.add_player(player2.id)
tournament2.add_player(player3.id)
tournament2.add_player(player4.id)
tournament2.add_player(player5.id)
tournament2.add_player(player6.id)

tournament2.create_knockout_round

binding.pry
nil