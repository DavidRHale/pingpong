class Player

  def initialize(options)
    @id = options['id'].to_i if option['id']
    @name = options['name']
    @nickname = options['nickname']
    @dominant_hand = options['dominant_hand']
    @skill_set = options['skill_set']
    @win_count = options['win_count'].to_i
    @loss_count = options['loss_count'].to_i
  end

  def save
  
  end

end