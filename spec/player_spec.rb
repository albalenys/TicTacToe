require_relative '../lib/models/player'
require_relative '../lib/models/game'

describe 'Player' do
  let(:human) { Player.new("human") }
  let(:computer) { Player.new("computer") }

  describe '#get_marker' do
    xit 'calls for user input' do
      human.stub(:gets) {'X'}
      expect{human.get_marker(computer)}.to change{human.marker}.from(nil).to('X')
    end
  end

  describe '#get_move' do
    xit 'humans can only choose unoccupied spots' do
    end

    it 'computers choose middle spot when available' do
      board = Array(1..9)
      computer.marker = 'O'
      expect{computer.get_move(board)}.to change{board[4]}.to('O')
    end
  end
end