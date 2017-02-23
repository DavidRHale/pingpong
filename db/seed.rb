require('pry')
require_relative('../models/player.rb')
require_relative('../models/game.rb')

Player.delete_all
Game.delete_all

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

player1.save
player2.save

game1 = Game.new({'game_date' => '2017/02/23', 'game_time' => '16:00'})
game2 = Game.new({'game_date' => '2017/02/25', 'game_time' => '15:00'})

game1.save
game2.save

binding.pry
nil