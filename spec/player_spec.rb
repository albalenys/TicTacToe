require_relative '../lib/models/player'
require_relative '../lib/models/game'

describe 'Player' do
  before(:all) do
    @player = Player.new("human")
    @player.marker = 'X'
    @computer = Player.new("computer")
    @computer.marker = 'O'
  end

  describe '#get_marker' do
    xit 'calls for user input' do
      @player.stub(:gets) {'X'}
      expect{@player.get_marker(computer)}.to change{@player.marker}.from(nil).to('X')
    end
  end

  describe '#get_move' do
    xit 'humans can only choose unoccupied spots' do
    end

    it 'computers choose middle spot when available' do
      board = Array(1..9)
      expect{@computer.get_move(board)}.to change{board[4]}.to('O')
    end

    it 'computers choose spots that will give diagonal win' do
      board = ['O', 'X', 3, 4, 'O', 6, 'X', 8, 9]
      expect{@computer.get_move(board)}.to change{board[8]}.to('O')
    end

    it 'computers choose spots that will give horizontal win' do
      board = [1, 'X', 3, 'O', 'O', 6, 'X', 8, 9]
      expect{@computer.get_move(board)}.to change{board[5]}.to('O')
    end

    it 'computers choose spots that will give vertical win' do
      board = ['O', 2, 'X', 'O', 5, 'X', 7, 8, 9]
      expect{@computer.get_move(board)}.to change{board[6]}.to('O')
    end

    it 'computers choose randomly when there is no best move' do
      board = ['O', 2, 3, 4, 'X', 6, 7, 8, 9]
      @computer.get_move(board)
      count = board.select { |spot| spot == 'O'}
      expect(count.length).to eq(2)
    end
  end
end