class Game

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @game_date = options['date']
  end

  def save
    sql = "INSERT INTO games "
  end

end