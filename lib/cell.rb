


class Cell
  attr_accessor :x, :y
  def initialize(x, y, alive = true)
    @x = x
    @y = y
    @alive = alive
    @state_eval = StateEval.new
  end

  def alive?
    @alive
  end

  def change_state?(board)
    state_eval.change_state?(self, board)
  end
end

