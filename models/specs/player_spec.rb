require('minitest/autorun')
require_relative('../game.rb')
require_relative('../player.rb')

class PlayerTest < MiniTest::Test

  def setup
    @player1 = Player.new({
  'name' => 'David Hale',
  'nickname' => 'The Admiral',
  'dominant_hand' => 'Right',
  'skill_set' => 'Backhand God',
  'win_count' => 0,
  'loss_count' => 0
  })
  end

  def test_win_increment
    @player1.add_win_or_loss(true)
    assert_equal(1, @player1.win_count)
  end

end