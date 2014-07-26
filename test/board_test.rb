require 'test/unit'
require 'awesome_print'
require 'board'
require 'cell'


class BoardTest < Test::Unit::TestCase


  def setup
    ord_one = [[0,1], [0,2], [1,0], [1,1], [2,1], [2,2], [3,-1], [3,0], [3,1]] 
    @map_one = {}
    ord_one.each do |x|
      cell = Cell.new(x[0], x[1])
      @map_one[cell.name] = cell
    end
  end


  def first
    assert("a" == 'b')
  end

  def test_map_one

    cell10 = @map_one["1_0"]
    assert_equal(1, cell10.row)
    assert_equal(0, cell10.col)

    assert_equal(3, @map_one["3_0"].row)
    assert_equal(0, @map_one["3_0"].col)

    assert_equal(3, @map_one["3_-1"].row)
    assert_equal(-1, @map_one["3_-1"].col)

  end

  def test_board_init
    cut = Board.new(@map_one)
    cs = cut.current_state

    assert_equal(3, cs["3_-1"].row)
    assert_equal(-1, cs["3_-1"].col)

    #cell that doesn't exist returns nil
    assert_equal(nil, cs["5_5"]) 

    #future_state is nil
    assert_equal(nil, cut.future_state)
  end


end


