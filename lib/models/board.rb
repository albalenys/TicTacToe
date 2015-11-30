class Board
  attr_accessor :spots

  def initialize
    @spots = Array(1..9)
  end

  def is_over?
    [@spots[0], @spots[1], @spots[2]].uniq.length == 1 ||
    [@spots[3], @spots[4], @spots[5]].uniq.length == 1 ||
    [@spots[6], @spots[7], @spots[8]].uniq.length == 1 ||
    [@spots[0], @spots[3], @spots[6]].uniq.length == 1 ||
    [@spots[1], @spots[4], @spots[7]].uniq.length == 1 ||
    [@spots[2], @spots[5], @spots[8]].uniq.length == 1 ||
    [@spots[0], @spots[4], @spots[8]].uniq.length == 1 ||
    [@spots[2], @spots[4], @spots[6]].uniq.length == 1
  end

  def is_tied?
    @spots.all? { |spots| spots == 'X' || spots == 'O' }
  end

  def to_s
    " _________________\n|     |     |     |\n|  #{@spots[0]}  |  #{@spots[1]}  |  #{@spots[2]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{@spots[3]}  |  #{@spots[4]}  |  #{@spots[5]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{@spots[6]}  |  #{@spots[7]}  |  #{@spots[8]}  |\n|_____|_____|_____|"
  end
end