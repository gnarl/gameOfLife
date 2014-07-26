
class Cell
  attr_accessor :col, :row
  attr_writer :alive

  def initialize(row, col, alive = true)
    @row = row 
    @col = col 
    @alive = alive
  end

  def alive?
    @alive
  end


  def name
    "#{@row}_#{@col}"
  end


end

