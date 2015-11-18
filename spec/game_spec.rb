require_relative '../lib/game'

describe 'Game' do
  @player_1 = 'X'
  @player_2 = 'O'
  @current_player = @player_1

  describe '#switch_player' do
    it 'switches to appropriate player' do
      expect(@current_player).to eq(@player_2)
    end
  end
end