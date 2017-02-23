require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/player.rb')

get '/players' do
  @players = Player.all
  erb(:'player/index')
end

get '/players/new' do
  erb(:'player/new')
end

post '/players' do
  player = Player.new(params)
  player.save
  erb(:'player/create')
end

get '/players/:id' do
  @player = Player.find(params[:id])
  erb(:'player/show')
end

get '/players/:id/edit' do
  @player = Player.find(params[:id])
  erb(:'player/edit')
end

post '/players/:id' do
  player = Player.new(params)
  player.update
  redirect to "/players/#{player.id}"
end

post '/players/:id/delete' do
  player = Player.find(params[:id])
  player.delete
  erb(:'player/destroy')
end