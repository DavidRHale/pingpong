require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/game.rb')

get '/games' do
  @games = Game.all
  erb(:'game/index')
end

get '/games/new' do 
  erb(:'game/new')
end

get '/games/:id' do
  @game = Game.find(params['id'])
  erb(:'game/show')
end

get '/games/:id/edit' do
  @game = Game.find(params['id'])
  erb(:'game/edit')
end

post '/games' do
  game = Game.new(params)
  game.save
  redirect to '/games'
end