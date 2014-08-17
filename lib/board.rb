require_relative 'cell'
require_relative 'state_eval'

class Board
  include StateEval 

  attr_reader :current_state, :future_state, :dead_neighbors

  def initialize(map)
    @current_state = map 
    @future_state = {}
    @dead_neighbors = []
  end

  #assumes @future_state is always properly initialized
  def add_future_cell(cell)
    @future_state[cell.name] = cell 
  end

  #  Any live cell with fewer than two live neighbours dies, as if caused by under-population.
  #  Any live cell with two or three live neighbours lives on to the next generation.
  #  Any live cell with more than three live neighbours dies, as if by overcrowding.
  #  Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
  
  #Dead cell reproduction
  # N N N N N
  # N L D L N
  # N N L N N
  #
  # N N L L N
  # N N D L N
  # N N N N N
  #d
  # N N N L N
  # N L D L N
  # N N N N N
  #

  def update_board

    update_future_state

    reset_neighbor_counts
    @dead_neighbors = []

    @current_state = @future_state
    @future_state = {}
  end

  def display_board
    puts "\n" 
    display = @current_state.keys.sort

    left_max_col = nil 
    right_max_col = nil
    display.each do |x|
      row, col = get_row_col(x)
      if left_max_col.nil?  
        left_max_col = col.to_i
      elsif col.to_i < left_max_col
        left_max_col = col.to_i
      end

      if right_max_col.nil? 
        right_max_col = col.to_i
      elsif col.to_i > right_max_col 
        right_max_col = col.to_i
      end
    end

    current_row = display[0].split('_')[0].to_i
    current_col = left_max_col 

    display.each do |x|
      row, col = get_row_col(x)

      if row > current_row 
        while current_col <= right_max_col do
          print "____|"
          current_col = current_col + 1
        end
        puts "\n" 
        current_row = row
        current_col = left_max_col
      end
      
      print_column(row, col, current_col)
      current_col = col + 1 
    end

    #DRY
    while current_col <= right_max_col do
      print "____|"
      current_col = current_col + 1
    end
    puts "\n" 

  end

  def print_column(row, col, current_col)

    while current_col < col do
      print "____|"
      current_col = current_col + 1
    end
    print "#{row}_#{col}|".rjust(5, '_')
    #puts current_col
 
  end
  
  def update_future_state
    @current_state.each do |key, cell|
      look_at_neighbors(cell)
      future_state[key] = cell if stays_alive?(cell)
    end

    process_dead_neighbors
  end

  #dependency on calling look_at_neighbors first
  def process_dead_neighbors

    @dead_neighbors.each do |dn|
      row, col = dn.split('_')      
      dead_cell = Cell.new(row.to_i, col.to_i, false)

      dead_cell.neighbors.each do |n_cell|
        if @current_state.include?(n_cell)
          dead_cell.inc_alive_neighbors
        end
      end

      if reproduces?(dead_cell)
        dead_cell.alive = true
        future_state[dn] = dead_cell 
      end
    end
  end

  def reset_neighbor_counts
    @future_state.each do |key, cell|
      cell.reset_alive_neighbors
    end
  end



  def look_at_neighbors(cell) 

    # inc num_alive neighbors
    # add to dead_neighbors if a dead neighbor
    cell.alive_neighbors = 0;
    
    cell.neighbors.each do |n_cell|
      if @current_state.include?(n_cell)
        cell.inc_alive_neighbors
      else
        unless @dead_neighbors.include?(n_cell)
          @dead_neighbors << n_cell
        end
      end
    end
  end

  private 

  def get_row_col(cell_name)
      row, col = cell_name.split('_') 
      return row.to_i, col.to_i
  end

end


