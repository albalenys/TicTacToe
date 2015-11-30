require_relative '../lib/models/player'
require_relative '../lib/models/game'
require 'stringio'

def capture_name
  $stdin.gets.chomp
end

describe 'Game' do
  before(:all) do
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
    it 'sets @type with valid input' do
      @game.stub(:gets) { '1' }
      @game.get_type
      expect(@game.type).to eq('1')
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
end