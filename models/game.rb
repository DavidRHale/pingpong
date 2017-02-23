require_relative('../db/sql_runner.rb')

class Game

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @game_date = options['game_date']
    @game_time = options['game_time']
  end

  def save
    sql = "INSERT INTO games (game_date, game_time) VALUES ('#{@game_date}', '#{@game_time}') RETURNING *;"
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

  def self.delete_all
    sql ="DELETE FROM games;"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM games WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

end