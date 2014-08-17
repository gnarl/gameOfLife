require_relative 'cell'
require_relative 'state_eval'
require_relative 'cell_output'

class Board
  include StateEval 
  include CellOutput

  attr_reader :current_state, :future_state, :dead_neighbors

  def initialize(map)
    @current_state = map 
    @future_state = {}
    @dead_neighbors = []
    @finished = false
  end

  #assumes @future_state is always properly initialized
  def add_future_cell(cell)
    @future_state[cell.name] = cell 
  end

  def finished?
    @finished
  end
  
  def regenerate 
    update_future_state

    reset_neighbor_counts
    @finished = true if @future_state == @current_state
    @current_state = @future_state

    @dead_neighbors = []
    @future_state = {}
  end

  def empty?
    @current_state.empty?
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

  def display
    cli_out(@current_state.values.sort)
  end


  private 
  def get_row_col(cell_name)
      row, col = cell_name.split('_') 
      return row.to_i, col.to_i
  end

end


