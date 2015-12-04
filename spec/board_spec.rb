require_relative '../lib/board'

describe 'Board' do
  before(:all) do
    @board = Board.new
  end

  describe '#three_in_row?' do
    it 'returns false with no wins' do
      @board.spots = Array(1..9)
      expect(@board.three_in_row?).to eq(false)
    end

    it 'returns true with diagonal win' do
      @board.spots = ['O', 'X', 3, 4, 'O', 6, 'X', 8, 'O']
      expect(@board.three_in_row?).to eq(true)
    end

    it 'returns true with horizontal win' do
      @board.spots = [1, 'X', 3, 'O', 'O', 'O', 'X', 8, 9]
      expect(@board.three_in_row?).to eq(true)
    end

    it 'returns true with vertical win' do
      @board.spots = ['O', 2, 'X', 'O', 5, 'X', 'O', 8, 9]
      expect(@board.three_in_row?).to eq(true)
    end
  end

  describe '#all_spots_taken??' do
    it 'returns false with no ties' do
      @board.spots = [1, 'X', 3, 'O', 'O', 6, 'X', 8, 9]
      expect(@board.all_spots_taken?).to eq(false)
    end

    it 'returns true with tied game' do
      @board.spots = ['X', 'X', 'O', 'O', 'O', 'X', 'X', 'X', 'O']
      expect(@board.all_spots_taken?).to eq(true)
    end
  end
end