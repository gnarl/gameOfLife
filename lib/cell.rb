
# Stores the state of a cell used by the board. 
# The cell knows where on the board it is.
# The cell knows if it is alive or dead.
# The cell can be told how many alive neighbors it has.
class Cell
  attr_accessor :col, :row, :alive_neighbors
  attr_writer :alive

  SELF_POSITION = 4

  def initialize(row, col, alive = true)
    @row = row 
    @col = col 
    @alive = alive
    @alive_neighbors = 0
  end

  def alive?
    @alive
  end

  def neighbors
    neighbors = []
    rows = (@row - 1)..(@row + 1)
    cols = (@col - 1)..(@col + 1)

    rows.each do |x|
      cols.each do |y|
          neighbors << create_name(x, y)
      end
    end

    neighbors.delete_at(SELF_POSITION) 
    neighbors 
  end

  def name
    create_name(@row, @col)
  end

  def inc_alive_neighbors
    @alive_neighbors = @alive_neighbors + 1
  end

  def reset_alive_neighbors
    @alive_neighbors = 0
  end

  private
  def create_name(row, col)
    "#{row}_#{col}"
  end

end

