#require 'awesome_print'
require_relative 'board'

SLEEP_TIME = 1.0/9.0

ord_one = [               [0,1], [0,2], 
                   [1,0], [1,1], 
                   [2,0], [2,1], [2,2], 
           [3,-1], [3,0], [3,1], [3,2],      
                                       [4,3], [4,4],
                                       [5,3] ]
@map_one = {}
ord_one.each do |x|
  cell = Cell.new(x[0], x[1])
  @map_one[cell.name] = cell
end


board = Board.new(@map_one)

i = 0

until board.finished?
  sleep(SLEEP_TIME)
  puts "board #{i}"
  board.display
  board.regenerate
  i = i + 1
end
