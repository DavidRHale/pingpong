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

end