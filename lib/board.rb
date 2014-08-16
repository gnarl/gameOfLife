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
    @dead_neighbors = []
    @current_state = @future_state
    @future_state = {}
  end
  
  def update_future_state

    @current_state.each do |key, cell|
      look_at_neighbors(cell)
      future_state[key] = cell if stays_alive?(cell)
    end

    process_dead_neighbors
    reset_neighbor_counts
  end

  #depends on look_at_neighbors being called
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


end


