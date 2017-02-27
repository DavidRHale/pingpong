require_relative('../db/sql_runner.rb')

class TournamentPlayer

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @player_id = options['player_id']
    @tournament_id = options['tournament_id']
  end

  def save
    sql = "INSERT INTO tournament_players (player_id, tournament_id) VALUES (#{@player_id}, #{@tournament_id}) RETURNING *"
    tournament_player = SqlRunner.run(sql).first
    @id = tournament_player['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM tournament_players;"
    tournament_players = SqlRunner.run(sql)
    return tournament_players.map { |tournament_player| TournamentPlayer.new(tournament_player) }
  end

  def delete
    sql = "DELETE FROM tournament_players WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.delete_all
    sql = "DELETE FROM tournament_players;"
    SqlRunner.run(sql)
  end


end