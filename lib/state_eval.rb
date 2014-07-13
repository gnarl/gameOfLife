require 'awesome_print'
require 'cell'


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

