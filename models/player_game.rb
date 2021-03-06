require_relative('../db/sql_runner.rb')

class PlayerGame

  attr_accessor :player_id, :game_id, :player_score, :tournament_id, :player_won
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @player_id = options['player_id'].to_i
    @game_id = options['game_id'].to_i
    @tournament_id = options['tournament_id'].to_i
    @player_score = options['player_score'].to_i
    @player_won = options['player_won'] if options['player_won']
  end

  def save
    sql = "INSERT INTO player_games (player_id, game_id, player_score, tournament_id #{(", player_won") unless @player_won == nil}) VALUES (#{@player_id}, #{@game_id}, #{@player_score}, #{@tournament_id}#{", #{@player_won}" unless @player_won == nil}) RETURNING *;"
    player_game = SqlRunner.run(sql).first
    @id = player_game['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM player_games;"
    player_games = SqlRunner.run(sql)
    return player_games.map { |player_game| PlayerGame.new(player_game) }
  end

  def self.find(id)
    sql = "SELECT * FROM player_games WHERE id = #{id}"
    player_game = SqlRunner.run(sql).first
    return PlayerGame.new(player_game)
  end

  def self.find_game_and_player(game_id, player_id)
    sql = "SELECT * FROM player_games WHERE game_id = #{game_id} AND player_id = #{player_id}"
    player_game = SqlRunner.run(sql).first
    return PlayerGame.new(player_game)
  end

  def update
    sql = "UPDATE player_games SET (player_id, game_id, player_score, tournament_id, player_won) = (#{@player_id}, #{@game_id}, #{@player_score}, #{@tournament_id}, #{@player_won}) WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM player_games WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete_all
    sql = "DELETE FROM player_games;"
    SqlRunner.run(sql)
  end

  def player
    sql = "SELECT * FROM players WHERE id = #{@player_id};"
    player = SqlRunner.run(sql).first
    return Player.new(player)
  end

  def game
    sql = "SELECT * FROM games WHERE id = #{@game_id};"
    game = SqlRunner.run(sql).first
    return Game.new(game)
  end

end