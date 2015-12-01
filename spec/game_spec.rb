require_relative '../lib/game'

describe 'Game' do
  before do
    Game.send(:public, *Game.private_instance_methods)
    @game = Game.new
  end

  describe '#switch_player' do
    it 'switches to other player' do
      @game.type = "1"
      @game.create_players
      @game.current_player = @game.player_1
      expect{@game.switch_player}.to change{@game.current_player}.from(@game.player_1).to(@game.player_2)
    end
  end

  describe '#get_type' do
    it 'changes @type with valid user input' do
      @game.input = StringIO.new("1")
      expect{ @game.get_type }.to change{ @game.type }.from(nil).to("1")
    end

    it 'does not change @type with invalid user input' do
    end
  end

  describe '#create_players' do
    it 'creates one human and one computer player with option 1' do
      @game.type = "1"
      @game.create_players
      expect(@game.player_1.type).to eq("human")
      expect(@game.player_2.type).to eq("computer")
    end

    it 'creates two human players with option 2' do
      @game.type = "2"
      @game.create_players
      expect(@game.player_1.type).to eq("human")
      expect(@game.player_2.type).to eq("human")
    end

    it 'creates two computer players with option 3' do
      @game.type = "3"
      @game.create_players
      expect(@game.player_1.type).to eq("computer")
      expect(@game.player_2.type).to eq("computer")
    end
  end

  describe '#get_first_player_turn' do
    xit 'sets current_player as opposite of user input' do
      @game.type = "1"
      @game.create_players
      @game.player_1.marker = "X"
      @game.player_2.marker = "O"
      @game.input = StringIO.new("X")
      expect{ @game.get_first_player_turn }.to change{ @game.current_player }.from(nil).to(@player_2)
    end

    it 'does not set current_player with invalid user input' do
    end
  end
end
