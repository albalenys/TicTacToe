require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/display'

describe 'Player' do
  before(:all) do
    @board = Board.new
    @player = Player.new("human")
    @player.marker = 'X'
    @computer = Player.new("computer")
    @computer.marker = 'O'
  end

  describe '#get_move' do
    context 'when safe from losing' do
      it 'computers choose middle spot when available' do
        @board.spots = Array(1..9)
        expect{@computer.get_move(@board)}.to change{@board.spots[4]}.to('O')
        count = @board.spots.select { |spot| spot == 'O'}
        expect(count.length).to eq(1)
      end

      it 'computers choose spots that will give diagonal win' do
        @board.spots = ['O', 'X', 3, 4, 'O', 6, 'X', 8, 9]
        expect{@computer.get_move(@board)}.to change{@board.spots[8]}.to('O')
        count = @board.spots.select { |spot| spot == 'O'}
        expect(count.length).to eq(3)
      end

      it 'computers choose spots that will give horizontal win' do
        @board.spots = [1, 'X', 3, 'O', 'O', 6, 'X', 8, 9]
        expect{@computer.get_move(@board)}.to change{@board.spots[5]}.to('O')
        count = @board.spots.select { |spot| spot == 'O'}
        expect(count.length).to eq(3)
      end

      it 'computers choose spots that will give vertical win' do
        @board.spots = ['O', 2, 'X', 'O', 5, 6, 7, 'X', 9]
        expect{@computer.get_move(@board)}.to change{@board.spots[6]}.to('O')
        count = @board.spots.select { |spot| spot == 'O'}
        expect(count.length).to eq(3)
      end

      it 'computers choose randomly when there is no best move' do
        @board.spots = ['O', 2, 3, 4, 'X', 6, 7, 8, 9]
        @computer.get_move(@board)
        count = @board.spots.select { |spot| spot == 'O'}
        expect(count.length).to eq(2)
      end
    end

    context 'when endanger of losing' do
      it 'computers avoid losing even with middle spot available' do
        @board.spots = ['O', 2, 'X', 4, 5, 'X', 7, 8, 9]
        expect{@computer.get_move(@board)}.to change{@board.spots[8]}.to('O')
        count = @board.spots.select { |spot| spot == 'O'}
        expect(count.length).to eq(2)
      end

      it 'computers avoid losing even with possible horizontal win' do
        @board.spots = ['X', 'X', 3, 'O', 'O', 6, 7, 8, 9]
        expect{@computer.get_move(@board)}.to change{@board.spots[2]}.to('O')
        count = @board.spots.select { |spot| spot == 'O'}
        expect(count.length).to eq(3)
      end

      it 'computers avoid losing even with possible vertical win' do
        @board.spots = ['O', 'X', 3, 'O', 'X', 6, 7, 8, 9]
        expect{@computer.get_move(@board)}.to change{@board.spots[7]}.to('O')
        count = @board.spots.select { |spot| spot == 'O'}
        expect(count.length).to eq(3)
      end
    end
  end
end