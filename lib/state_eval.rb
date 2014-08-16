require 'awesome_print'
require 'cell'


module StateEval 

  MIN_ALIVE_NEIGHBORS = 1
  MAX_ALIVE_NEIGHBORS = 4 
  REPRODUCE_ALIVE_NEIGHBORS = 3

  def stays_alive?(cell)
    if (MIN_ALIVE_NEIGHBORS < cell.alive_neighbors &&
        cell.alive_neighbors < MAX_ALIVE_NEIGHBORS)
      return true
    end
    false
  end

  def reproduces?(cell)
    if cell.alive_neighbors == REPRODUCE_ALIVE_NEIGHBORS
      return true
    end
    false 
  end

end

