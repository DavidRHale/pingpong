require_relative('../db/sql_runner.rb')

class Player

  attr_accessor :name, :nickname, :dominant_hand, :skill_set, :win_count, :loss_count
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @nickname = options['nickname']
    @dominant_hand = options['dominant_hand']
    @skill_set = options['skill_set']
    @win_count = options['win_count'].to_i
    @loss_count = options['loss_count'].to_i
  end

  def save
    sql = "INSERT INTO players (name, nickname, dominant_hand, skill_set, win_count, loss_count) VALUES ('#{@name}', '#{@nickname}', '#{@dominant_hand}', '#{@skill_set}', #{@win_count}, #{@loss_count}) RETURNING *;"
    player = SqlRunner.run(sql).first
    @id = player['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM players;"
    players = SqlRunner.run(sql)
    return players.map { |player| Player.new(player) }
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM players WHERE id = #{id};"
    player = SqlRunner.run(sql).first
    return Player.new(player)
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM players WHERE name = '#{name}';"
    player = SqlRunner.run(sql).first
    return Player.new(player)
  end

  def update
    sql = "UPDATE players SET (name, nickname, dominant_hand, skill_set, win_count, loss_count) = ('#{@name}', '#{@nickname}', '#{@dominant_hand}', '#{@skill_set}', #{@win_count}, #{@loss_count}) WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.delete_all
    sql = "DELETE FROM players;"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM players WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def score(game_id)
    sql = "SELECT player_score FROM player_games WHERE game_id = #{game_id} AND player_id = #{@id};"
    score = SqlRunner.run(sql).first
    return score.values.first.to_i
  end

  def add_win_or_loss(win_loss)
    @win_count += 1 if win_loss == true
    @loss_count += 1 if win_loss == false
  end

  def last_5_games
    sql = "SELECT g.* FROM games g INNER JOIN player_games pg ON pg.game_id = g.id WHERE pg.player_id = #{@id} AND player_won IS NOT NULL ORDER BY game_date DESC LIMIT 5;"
    games = SqlRunner.run(sql)
    return games.map { |game| Game.new(game) }
  end

  def games
    sql = "SELECT g.* FROM games g INNER JOIN player_games pg ON pg.game_id = g.id WHERE pg.player_id = #{@id}"
    games = SqlRunner.run(sql)
    return games.map { |game| Game.new(game) }
  end
  
  def self.rankings
    sql = "SELECT * FROM players ORDER BY win_count DESC;"
    players = SqlRunner.run(sql)
    return players.map { |player| Player.new(player) }
  end

end