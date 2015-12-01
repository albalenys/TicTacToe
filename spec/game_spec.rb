require_relative '../lib/game'

describe 'Game' do
  before(:all) do
    @game = Game.new
  end

  describe '#switch_player' do
    xit 'switches to other player' do
      @game.instance_variable_set(:type, 1)
      # @game.type = "1"
      @game.create_players
      @game.current_player = @game.player_1
      expect{@game.switch_player}.to change{@game.current_player}.from(@game.player_1).to(@game.player_2)
    end
  end

  describe '#create_players' do
    xit 'creates one human and one computer player with option 1' do
      @game.type = "1"
      @game.create_players
      expect(@game.player_1.type).to eq("human")
      expect(@game.player_2.type).to eq("computer")
    end

    xit 'creates two human players with option 2' do
      @game.type = "2"
      @game.create_players
      expect(@game.player_1.type).to eq("human")
      expect(@game.player_2.type).to eq("human")
    end

    xit 'creates two computer players with option 3' do
      @game.type = "3"
      @game.create_players
      expect(@game.player_1.type).to eq("computer")
      expect(@game.player_2.type).to eq("computer")
    end
  end
end