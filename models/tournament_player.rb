require_relative('../db/sql_runner.rb')

class TournamentPlayer

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @player_id = options['player_id']
    @tournament_id = options['tournament_id']
  end

end