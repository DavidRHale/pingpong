class Player

  def initialize(options)
    @id = options['id'].to_i if option['id']
    @name = options['name']
    @nickname = options['nickname']
    @win_count = options['win_count']
  end

end