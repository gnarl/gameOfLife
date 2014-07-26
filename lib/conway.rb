require 'awesome_print'
require 'state_eval'
require 'cell'

#TODO
# Determine if neighbors reproduce
#
# * output visual of board changes
# * switch to only tracking alive cells 



#living_board =  [Cell.new(0,1, true),  Cell.new(0,2,true),
#                 Cell.new(1,1, true),  Cell.new(1,2,true),
#                 Cell.new(1,1, true)]


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
#state_eval = StateEval.new
#puts state_eval.num_alive_neighbors(Cell.new(1,1, true), board) == 5
#puts state_eval.change_state?(Cell.new(1,1, true), board) == true

##############################
