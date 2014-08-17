#require 'awesome_print'
require_relative 'board'

ord_one = [               [0,1], [0,2], 
                   [1,0], [1,1], 
                   [2,0], [2,1], [2,2], 
           [3,-1], [3,0], [3,1], [3,2]          ] 
@map_one = {}
ord_one.each do |x|
  cell = Cell.new(x[0], x[1])
  @map_one[cell.name] = cell
end


board = Board.new(@map_one)

25.times do
  board.display
  board.update_board
end
