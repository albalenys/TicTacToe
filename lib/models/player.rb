class Player
  attr_accessor :marker

  def initialize
    @marker =  nil
  end

  def get_marker
    self.marker = gets.chomp.upcase!

    until (self.marker == "X" || self.marker == "O")
      puts "Invalid input; select to play as either 'X' or 'O'."
      self.marker = gets.chomp.upcase!
    end
  end
end