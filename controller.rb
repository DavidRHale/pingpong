require('sinatra')
require('sinatra/contrib/all')
require_relative('./models/player.rb')

get '/players' do
  @players = Player.all
  erb(:index)
end

get '/players/new' do
  erb(:new)
end

post '/players' do
  player = Player.new(params)
  player.save
  erb(:create)
end

get '/players/:id' do
  @player = Player.find(params[:id])
  erb(:show)
end

get '/players/:id/edit' do
  @player = Player.find(params[:id])
  erb(:edit)
end

post '/players/:id' do
  player = Player.new(params)
  player.update
  redirect to "/players/#{player.id}"
end