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
    @win_count = 0 || options['win_count'].to_i
    @loss_count = 0 || options['loss_count'].to_i
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
    sql = "UPDATE players SET (name, nickname, dominant_hand, skill_set) = ('#{@name}', '#{@nickname}', '#{@dominant_hand}', '#{@skill_set}') WHERE id = #{@id}"
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

end