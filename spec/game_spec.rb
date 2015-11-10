require_relative '../lib/game'

#comment out the start of game in game.rb before running tests.

describe 'Game' do
  @player_1 = 'X'
  @player_2 = 'O'
  @current_player = @player_1

  describe '#switch_player' do
    it 'switches to appropriate player' do
      expect(@current_player).to eq(@player_2)
    end
  end

  describe '#get_comp_spot' do
    it 'chooses middle spot when available' do
      @board = [1,'O',3,4,5,'X',7,8,9]
      expect(@last_move).to eq(5)
    end
  end
end