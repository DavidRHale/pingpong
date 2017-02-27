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

  def players
    sql = "SELECT p.* FROM players p INNER JOIN tournament_players tp ON p.id = tp.player_id WHERE tp.tournament_id = #{@id};"
    players = SqlRunner.run(sql)
    return players.map { |player| Player.new(player) }
  end

  def games
    sql = "SELECT * FROM games WHERE tournament_id = #{@id}"
    games = SqlRunner.run(sql)
    return games.map { |game| Game.new(game) }
  end

end