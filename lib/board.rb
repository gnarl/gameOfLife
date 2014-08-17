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

  #TODO rename
  def update_board

    update_future_state

    reset_neighbor_counts
    @dead_neighbors = []

    @current_state = @future_state
    @future_state = {}
  end

  def empty?
    @current_state.empty?
  end

  def display
    puts "\n" 
    display = @current_state.values.sort

    left_max_col = nil 
    right_max_col = nil
    display.each do |x|
      if left_max_col.nil?  
        left_max_col = x.col 
      elsif x.col < left_max_col
        left_max_col = x.col 
      end

      if right_max_col.nil? 
        right_max_col = x.col 
      elsif x.col > right_max_col 
        right_max_col = x.col 
      end
    end

    current_row = display[0].row
    current_col = left_max_col 

    display.each do |x|

      while x.row > current_row 
        while current_col <= right_max_col do
          print "____|"
          current_col = current_col + 1
        end
        puts "\n" 
        current_row = current_row + 1 
        current_col = left_max_col
      end
      
      print_column(x.row, x.col, current_col)
      current_col = x.col + 1 
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


