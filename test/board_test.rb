require 'test/unit'
require 'awesome_print'
require 'board'
require 'cell'


class BoardTest < Test::Unit::TestCase

  def setup
    ord_one = [               [0,1], [0,2], 
                       [1,0], [1,1], 
                       [2,0], [2,1], [2,2], 
               [3,-1], [3,0], [3,1]           ] 
    @map_one = {}
    ord_one.each do |x|
      cell = Cell.new(x[0], x[1])
      @map_one[cell.name] = cell
    end
  end

  
  def test_board_init
    cut = Board.new(@map_one)
    cs = cut.current_state

    assert_equal(3, cs["3_-1"].row)
    assert_equal(-1, cs["3_-1"].col)

    #cell that doesn't exist returns nil
    assert_equal(nil, cs["5_5"]) 

    #future_state is nil
    assert_equal({}, cut.future_state)
  end

  def test_add_future_cell
    cut = Board.new(@map_one)
    cs = cut.current_state
    cut.add_future_cell(cs["3_-1"])

    assert_equal(3, cut.future_state["3_-1"].row)
  end

  def test_look_at_neighbors
    cut = Board.new(@map_one)
    cs = cut.current_state 

    dead_neighbors1 = ["2_-2", "2_-1", "3_-2", "4_-2", "4_-1", "4_0"]
    dead_neighbors2 = dead_neighbors1 + ["0_0", "1_2"]

    cell01 = cs["3_-1"]
    assert_equal(0, cell01.alive_neighbors)
    cut.look_at_neighbors(cell01)
    assert_equal(2, cell01.alive_neighbors)
    assert_equal(dead_neighbors1, cut.dead_neighbors)

    cell02 = cs["1_1"]
    assert_equal(0, cell02.alive_neighbors)
    cut.look_at_neighbors(cell02)
    assert_equal(6, cell02.alive_neighbors)
    assert_equal(dead_neighbors2, cut.dead_neighbors)

  end

  def test_update_future_state
    cut = Board.new(@map_one)

    cut.update_future_state


  end

end


