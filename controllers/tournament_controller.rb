require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/tournament.rb')

get '/tournaments' do
  @tournaments = Tournament.all
  erb(:'tournament/index')
end

get '/tournaments/:id' do
  @tournament = Tournament.find(params[:id])
  @players = @tournament.tournament_players
  @games = @tournament.tournament_games
  erb(:'tournament/show')
end