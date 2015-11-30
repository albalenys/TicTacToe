class Board
  def initialize
    @display = Array(1..9)
  end

  def is_over?
    [@display[0], @display[1], @display[2]].uniq.length == 1 ||
    [@display[3], @display[4], @display[5]].uniq.length == 1 ||
    [@display[6], @display[7], @display[8]].uniq.length == 1 ||
    [@display[0], @display[3], @display[6]].uniq.length == 1 ||
    [@display[1], @display[4], @display[7]].uniq.length == 1 ||
    [@display[2], @display[5], @display[8]].uniq.length == 1 ||
    [@display[0], @display[4], @display[8]].uniq.length == 1 ||
    [@display[2], @display[4], @display[6]].uniq.length == 1
  end

  def is_tied?
    @display.all? { |spots| spots == 'X' || spots == 'O' }
  end

  def to_s
    " _________________\n|     |     |     |\n|  #{@display[0]}  |  #{@display[1]}  |  #{@display[2]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{@display[3]}  |  #{@display[4]}  |  #{@display[5]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{@display[6]}  |  #{@display[7]}  |  #{@display[8]}  |\n|_____|_____|_____|"
  end
end