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

  def delete
    sql = "DELETE FROM tournament_players WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.delete_all
    sql = "DELETE FROM tournament_players;"
    SqlRunner.run(sql)
  end

end