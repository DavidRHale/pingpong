class PlayerGame

  attr_accessor :player_id, :game_id, :player_score, :player_won
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @player_id = options['player_id'].to_i
    @game_id = options['game_id'].to_i
    @player_score = options['player_score'].to_i
    @player_won = options['player_won']
  end

end