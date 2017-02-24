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

  @player2 = Player.new({
    'name' => 'Lorna Hale',
    'nickname' => 'The Wimp',
    'dominant_hand' => 'Right',
    'skill_set' => 'None',
    'win_count' => 0,
    'loss_count' => 0
    })
  end

  def test_win_increment
    @player1.add_win_or_loss(true)
    @player2.add_win_or_loss(false)
    assert_equal(1, @player1.win_count)
    assert_equal(1, @player2.loss_count)
  end

end