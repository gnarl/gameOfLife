

class Board
  attr_accessor :set

  def initialize(set)
    @set = set
  end

  def tick
    board.each
  end
end


