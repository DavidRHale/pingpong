require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/tournament.rb')
require_relative('../models/tournament_player.rb')

get '/tournaments' do
  @tournaments = Tournament.all
  erb(:'tournament/index')
end

get '/tournaments/new' do
  erb(:'tournament/new')
end

get '/tournaments/:id' do
  @tournament = Tournament.find(params[:id])
  @players = @tournament.tournament_players
  @round = @tournament.round_number
  @games = @tournament.tournament_games
  erb(:'tournament/show')
end

post '/tournaments' do
  @tournament = Tournament.new(params)
  @tournament.save
  @players = Player.all
  erb(:'tournament/add-player')
end

get '/tournaments/add-player' do
  @players = Player.all
  erb(:'tournament/add-player')
end

post '/tournaments/:id/delete' do
  tournament = Tournament.find(params[:id])
  tournament.delete
  erb(:'tournament/destroy')
end

get '/tournaments/:id/edit' do
  @tournament = Tournament.find(params[:id])
  erb(:'tournament/edit')
end

post '/tournaments/add-player' do
  tournament = Tournament.find_by_name(params['tournament_name'])
  params.delete('tournament_name')
  players =[]
  params.each_value do |name|
    player = Player.find_by_name(name)
    players.push(player)
  end
  players.each { |player| tournament.add_player(player.id) }
  if tournament.format == "League"
    tournament.create_league_fixtures
  else
    tournament.create_knockout_round
  end
  erb(:'tournament/create')
end

post '/tournaments/:id/next-round' do
  @tournament = Tournament.find(params[:id])
  @tournament.create_knockout_round
  redirect to redirect to "/tournaments/#{@tournament.id}"
end

post '/tournaments/:id' do
  tournament = Tournament.new(params)
  tournament.update
  redirect to "/tournaments/#{tournament.id}"
end