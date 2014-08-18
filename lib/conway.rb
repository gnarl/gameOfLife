require_relative 'board'
require 'json'
SLEEP_TIME = 1.0/9.0

def create_map(seeds)
  map = {}
  seeds.each do |x|
    cell = Cell.new(x[0], x[1])
    map[cell.name] = cell
  end
  map
end

def run_sim(board)
  i = 0
  
  until board.finished?
    sleep(SLEEP_TIME)
    puts "board #{i}"
    board.display
    board.regenerate
    i = i + 1
  end
end

###########################################
filename = ARGV.shift
abort "Need a seed filename to run the game." unless filename

puts "Creating game from seed file: #{filename}"
json = File.read(filename)
seeds = JSON.parse(json)

board = Board.new(create_map(seeds))
run_sim(board)

