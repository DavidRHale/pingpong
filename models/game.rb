require_relative('../db/sql_runner.rb')

class Game

  attr_accessor :game_date, :tournament_id, :tournament_round
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @game_date = options['game_date']
    @tournament_id = options['tournament_id'].to_i
    @tournament_round = options['tournament_round'].to_i if options['tournament_round']
  end

  def save
    sql = "INSERT INTO games (game_date, tournament_id #{", tournament_round" unless @tournament_round == nil }) VALUES ('#{@game_date}', #{@tournament_id} #{", #{@tournament_round}" unless @tournament_round == nil}) RETURNING *;"
    game = SqlRunner.run(sql).first
    @id = game['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM games;"
    games = SqlRunner.run(sql)
    return games.map { |game| Game.new(game) }
  end

  def self.find(id)
    sql = "SELECT * FROM games WHERE id = #{id}"
    game = SqlRunner.run(sql).first
    return Game.new(game)
  end

  def update
    sql = "UPDATE games SET (game_date #{", tournament_round" unless @tournament_round == nil}) = ('#{@game_date}' #{", " + @tournament_round unless @tournament_round == nil}) WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete_all
    sql ="DELETE FROM games;"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM games WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def players
    sql = "SELECT players.* FROM players INNER JOIN player_games ON player_games.player_id = players.id WHERE game_id = #{@id}"
    players = SqlRunner.run(sql)
    return players.map { |player| Player.new(player) }
  end

  def player_names
    sql = "SELECT players.name FROM players INNER JOIN player_games ON player_games.player_id = players.id WHERE game_id = #{@id}"
    names = SqlRunner.run(sql)
    return names.map {|name| name['name']}
  end

  def scores
    sql = "SELECT player_score FROM player_games WHERE game_id = #{@id};"
    scores = SqlRunner.run(sql)
    return scores.values
  end

  def winner
    sql = "SELECT players.* FROM players INNER JOIN player_games ON player_games.player_id = players.id WHERE player_games.player_won = true AND player_games.game_id = #{@id};"
    winner = SqlRunner.run(sql).first

    if winner == nil
      return nil
    else
      return Player.new(winner)
    end
  end

  def loser(tournament_id)
    sql = "SELECT p.* FROM players p INNER JOIN player_games pg ON pg.player_id = p.id WHERE pg.player_won = false AND pg.game_id = #{@id} AND pg.tournament_id = #{tournament_id};"
    loser = SqlRunner.run(sql).first
    loser = Player.new(loser) unless loser == nil
    return loser
  end

end