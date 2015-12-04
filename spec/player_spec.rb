require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/display'

describe 'Player' do
  before do
    Player.send(:public, *Player.private_instance_methods)
    @board = Board.new
    @player = Player.new("human")
    @player.marker = 'X'
    @computer = Player.new("computer")
    @computer.marker = 'O'
  end

  describe '#get_marker' do
    xit 'changes @marker with valid user input' do
      @player.input = StringIO.new("X")
      expect{ @player.get_marker(@computer) }.to change{ @player.marker }.from(nil).to("X")
    end

    xit 'does not change @marker with invalid user input' do
    end
  end

  describe '#get_move' do
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

    it 'computers choose spots that avoid lost' do
      @board.spots = ['X', 2, 'O', 'X', 5, 'O', 7, 8, 9]
      expect{@computer.get_move(@board).to change(@board.spots[6].to ('O'))}
      # count = @board.spots.select { |spot| spot == 'O'}
      # expect(count.length).to eq(3)
    end

    it 'computers choose randomly when there is no best move' do
      @board.spots = ['O', 2, 3, 4, 'X', 6, 7, 8, 9]
      @computer.get_move(@board)
      count = @board.spots.select { |spot| spot == 'O'}
      expect(count.length).to eq(2)
    end
  end
end