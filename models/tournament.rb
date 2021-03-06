require_relative('../db/sql_runner.rb')
require_relative('./player.rb')
require_relative('./game.rb')

class Tournament

  attr_accessor :name, :format
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @format = options['format']
  end

  def save
    sql = "INSERT INTO tournaments (name, format) VALUES ('#{@name}', '#{@format}') RETURNING *;"
    tournament = SqlRunner.run(sql).first
    @id = tournament['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM tournaments;"
    tournaments = SqlRunner.run(sql)
    return tournaments.map { |tournament| Tournament.new(tournament) }
  end

  def self.find(id)
    sql = "SELECT * FROM tournaments WHERE id = #{id}"
    tournament = SqlRunner.run(sql).first
    return Tournament.new(tournament)
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM tournaments WHERE name = '#{name}'"
    tournament = SqlRunner.run(sql).first
    return Tournament.new(tournament)
  end

  def update
    sql = "UPDATE tournaments SET (name, format) = ('#{@name}', '#{@format}') WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM tournaments WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.delete_all
    sql = "DELETE FROM tournaments"
    SqlRunner.run(sql)
  end

  def tournament_players
    sql = "SELECT p.* FROM players p INNER JOIN tournament_players tp ON p.id = tp.player_id WHERE tp.tournament_id = #{@id};"
    players = SqlRunner.run(sql)
    return players.map { |player| Player.new(player) }
  end

  def players_not_lost
    players = tournament_players
    losers = tournament_losers

    if losers != []
      current_players = losers.each do |loser| 
      players.each {|player| players.delete(player) if player.id == loser.id }
    end
      return players
    else
      return players
    end
    
  end

  def tournament_games
    sql = "SELECT * FROM games WHERE tournament_id = #{@id}"
    games = SqlRunner.run(sql)
    return games.map { |game| Game.new(game) }
  end

  def add_player(id)
    player = Player.find_by_id(id)
    tournament_player = TournamentPlayer.new({'player_id' => player.id, 'tournament_id' => @id})
    tournament_player.save
  end

  def tournament_losers
    games = tournament_games
    losers = []

    games.each do |game| 
      loser = game.loser(@id) 
      losers.push(loser) unless loser == nil
    end

    return losers
  end

  def tournament_winner
    return players_not_lost.first if players_not_lost.length == 1
  end

  def create_player_list
    players = players_not_lost
    num_of_players = players.count

    if num_of_players.odd?
      bye_player = players.sample
      players.delete(bye_player)
    end

    return players
  end

  def round_number
    starting_players_length = tournament_players.count
    current_players_length = players_not_lost.count

    current_players_length += 1 if current_players_length.odd?

    case
      when starting_players_length == current_players_length
        return 1
      when (starting_players_length / 2) == current_players_length
        return 2
      when (starting_players_length / 4) == current_players_length
        return 3
      when (starting_players_length / 8) == current_players_length
        return 4
      when (starting_players_length / 16) == current_players_length
        return 5
      when (starting_players_length / 32) == current_players_length
        return 6
    end
  end

  def create_league_fixtures
    players = tournament_players
    num_of_players = players.count

    counter = 0
    while true
      break if counter == 0.5 * num_of_players * (num_of_players - 1)
      player1 = players.sample
      player2 = players.sample

      # gives an array of game objects
      games = tournament_games 

      #replaces the game objects with an array of 2 names
      players_in_games = games.map {|game| game.player_names} 

      # makes an array of booleans checking if names are already in games
      game_made = players_in_games.map do |name_array| (name_array.include? player1.name) && (name_array.include? player2.name)
      end 

      # check if array inclues true and makes it true or false
      game_made = game_made.include? true

      # if players are not the same and the game is not made it will create the game and increment counter
      if (player1 != player2) && (!game_made)
        game = Game.new({'game_date' => (Date.today + counter + 1), 'tournament_id' => @id})
        game.save

        player_game1 = PlayerGame.new({'player_id' => player1.id.to_i, 'game_id' => game.id.to_i, 'tournament_id' => @id, 'player_score' => 0, 'player_won' => false})
        player_game2 = PlayerGame.new({'player_id' => player2.id, 'game_id' => game.id, 'tournament_id' => @id, 'player_score' => 0, 'player_won' => false})
        player_game1.save
        player_game2.save

        counter += 1
      end
    end
  end

  def create_knockout_round
      round = round_number
      starting_players = tournament_players
      current_players = create_player_list
      num_of_players = current_players.count

      return current_players[0] if num_of_players == 1

      counter = 0
      games = []

      while true
        break if counter == (num_of_players / 2)

        players_in_games = games.map { |game| game.player_names } 

        player1 = current_players.sample
        player2 = current_players.sample

        player_played = players_in_games.map do |name_array| (name_array.include? player1.name) || (name_array.include? player2.name)
        end

        player_played = player_played.include? true

        if (player1 != player2) && (!player_played)
          game = Game.new({'game_date' => (Date.today + counter + 1), 'tournament_id' => @id, 'tournament_round' => round})
          games.push(game)
          game.save

          player_game1 = PlayerGame.new({'player_id' => player1.id.to_i, 'game_id' => game.id.to_i, 'tournament_id' => @id, 'player_score' => 0})
          player_game2 = PlayerGame.new({'player_id' => player2.id, 'game_id' => game.id, 'tournament_id' => @id, 'player_score' => 0})
          player_game1.save
          player_game2.save

          counter += 1
        end
      end
    end

end