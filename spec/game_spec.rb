require_relative '../lib/game'

describe 'Game' do
  @player_1 = 'X'
  @player_2 = 'O'
  @current_player = @player_1

  describe 'switch_player' do
    it 'switches to appropriate player' do
      expect(@current_player).to eq(@player_2)
    end
  end

  describe 'get_comp_type' do
    @board = [1,'O',3,4,5,'X',7,8,9]
    it 'chooses middle spot when available' do
      expect(@last_move).to eq(5)
    end
  end
end