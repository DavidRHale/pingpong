require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/game.rb')
require_relative('../models/player.rb')
require_relative('../models/player_game.rb')

get '/games' do
  @games = Game.all
  erb(:'game/index')
end

get '/games/new' do 
  @tournaments = Tournament.all
  erb(:'game/new')
end

get '/games/:id' do
  @game = Game.find(params['id'])
  @player1 = @game.players[0]
  @player2 = @game.players[1]
  erb(:'game/show')
end

get '/games/:id/edit' do
  @game = Game.find(params['id'])
  erb(:'game/edit')
end

post '/games/:id' do
  game = Game.new(params)
  game.update
  
  player1 = Player.find_by_name(params['player1_name'])
  player2 = Player.find_by_name(params['player2_name'])
  
  player1_result = params['player1_score'].to_i > params['player2_score'].to_i
  player2_result = params['player2_score'].to_i > params['player1_score'].to_i
  
  player1.add_win_or_loss(player1_result)
  player2.add_win_or_loss(player2_result)

  player1.update
  player2.update

  player_game1 = PlayerGame.find_game_and_player(game.id, player1.id)
  player_game2 = PlayerGame.find_game_and_player(game.id, player2.id)

  player_game1.player_score = params['player1_score'].to_i
  player_game1.player_won = player1_result

  player_game2.player_score = params['player2_score'].to_i
  player_game2.player_won = player2_result

  player_game1.update
  player_game2.update
  erb(:'game/update')
end

post '/games' do
  game = Game.new(params)
  game.save
  
  player1 = Player.find_by_name(params['player1_name'])
  player2 = Player.find_by_name(params['player2_name'])
  
  player1_result = params['player1_score'].to_i > params['player2_score'].to_i
  player2_result = params['player2_score'].to_i > params['player1_score'].to_i
  
  player1.add_win_or_loss(player1_result)
  player2.add_win_or_loss(player2_result)

  player1.update
  player2.update

  player_game1 = PlayerGame.new({
    'player_id' => player1.id, 
    'game_id' => game.id, 
    'player_score' => params['player1_score'], 
    'tournament_id' => params['tournament_id'],
    'player_won' => player1_result})
  player_game2 = PlayerGame.new({
    'player_id' => player2.id, 
    'game_id' => game.id, 
    'player_score' => params['player2_score'], 
    'tournament_id' => params['tournament_id'],
    'player_won' => player2_result})
  player_game1.save
  player_game2.save
  redirect to '/games'
end

post '/games/:id/delete' do
  game = Game.find(params['id'])
  game.delete
  erb(:'game/destroy')
end

