require 'awesome_print'

#TODO
# Determine if neighbors reproduce
#
# * output visual of board changes
# * switch to only tracking alive cells 

class Cell
  attr_accessor :x, :y
  def initialize(x, y, alive)
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

class Board
  attr_accessor :set

  def initialize(set)
    @set = set
  end

  def tick
    board.each
  end
end

class StateEval 

  def num_alive_neighbors(cell, board)
    x = cell.x
    y = cell.y

    count = 0
    board.set.each do |board_cell|
       if ((x-1)..(x+1)).include?(board_cell.x) &&
           ((y-1)..(y+1)).include?(board_cell.y)
         unless (x != board_cell.x && y != board_cell.y)
           count = count + 1 if board_cell.alive? 
         end
       end
    end
    count
  end

  def change_state?(cell, board)
    count = num_alive_neighbors(cell, board) 
    
    if (cell.alive?)
      if (under_populated?(count)) 
        change = true;
      end
  
      if (over_populated?(count))
        change = true;
      end
    else
      if (reproduce?(count) && !cell.alive?)
        change = true
      end
    end
    change
  end

  def reproduce?(count)
    #stub
    false
  end

  def under_populated?(count)
    if (count < 2 ) 
      return true
    end
    false
  end

  def over_populated?(count)
    if (count > 3 )
      return true
    end
    false
  end

end

living_board =  [Cell.new(0,1, true),  Cell.new(0,2,true),
                 Cell.new(1,1, true),  Cell.new(1,2,true),
                 Cell.new(1,1, true)]


initial_board = [Cell.new(0,0, false), Cell.new(0,1, true),  Cell.new(0,2,true),
                 Cell.new(1,0, false), Cell.new(1,1, true),  Cell.new(1,2,true),
                 Cell.new(1,0, false), Cell.new(1,1, true),  Cell.new(1,2,true)]
board = Board.new(initial_board)
#ap board

##############################

# Test Cell
cell = Cell.new(2,2, false)
puts cell.class == Cell
puts cell.alive? == false

#Test Board
puts board.class == Board

#Test state eval
state_eval = StateEval.new
puts state_eval.num_alive_neighbors(Cell.new(1,1, true), board) == 5
puts state_eval.change_state?(Cell.new(1,1, true), board) == true

##############################
