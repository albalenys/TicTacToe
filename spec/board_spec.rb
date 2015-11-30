require_relative '../lib/models/board'

describe 'Board' do
  before(:all) do
    @board = Board.new
  end

  describe '#is_over?' do
    it 'returns false with no wins' do
      @board.spots = Array(1..9)
      expect(@board.is_over?).to eq(false)
    end

    it 'returns true with diagonal win' do
      @board.spots = ['O', 'X', 3, 4, 'O', 6, 'X', 8, 'O']
      expect(@board.is_over?).to eq(true)
    end

    it 'returns true with horizontal win' do
      @board.spots = [1, 'X', 3, 'O', 'O', 'O', 'X', 8, 9]
      expect(@board.is_over?).to eq(true)
    end

    it 'returns true with vertical win' do
      @board.spots = ['O', 2, 'X', 'O', 5, 'X', 'O', 8, 9]
      expect(@board.is_over?).to eq(true)
    end
  end

  describe '#is_tied?' do
    it 'returns false with no ties' do
      @board.spots = [1, 'X', 3, 'O', 'O', 6, 'X', 8, 9]
      expect(@board.is_tied?).to eq(false)
    end

    it 'returns true with tied game' do
      @board.spots = ['X', 'X', 'O', 'O', 'O', 'X', 'X', 'X', 'O']
      expect(@board.is_tied?).to eq(true)
    end
  end
end