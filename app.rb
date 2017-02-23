require('sinatra')
require('sinatra/contrib/all')
require_relative('./controllers/game_controller.rb')
require_relative('./controllers/player_controller.rb')

get '/' do 
  erb(:index)
end